#encoding: utf-8

class Admin::EventsController < Admin::ApplicationController
  include NewEvent
  before_filter :authenticate_professional!
  before_filter :load_salon

  def index    

    @events = @salon.events.order("start_at").includes(:client,:professional)
    @events = @events.today if params[:date] == "today"
    @events = @events.mine(current_professional.id) if params[:professional]    
    @professionals_with_services = current_professional.salon.professionals.includes(:professional_services).includes(:events).where("professional_services.service_id is not null")
    if params[:past_events]
      @events = @events.scoped
    else
      @events = @events.from_today_on
    end
    @month = params[:month] ? Time.zone.parse(params[:month]) : Time.zone.today
    @date = @month
    respond_to do |format|
     format.js
     format.json
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def get_events
    @events = current_professional.events.where(
      "start_at >= ? and end_at <= ?",
      Time.at(params['start'].to_i).to_formatted_s(:db),
      Time.at(params['end'].to_i).to_formatted_s(:db) 
      )
    events = [] 
    @events.each do |event|
      events << {
        :id => event.id, 
        :title => event.title, 
        :description => event.description,
        :url => url_for(:controller => 'admin/events', :action => "show", :id => event.id),
        :start => "#{event.start_at.iso8601}", 
        :end => "#{event.end_at.iso8601}",
        :allDay => false,
        :shown_title => "<b>#{event.start_at.strftime('%H:%M')}</b> - #{event.title}"
      }
    end
    render :text => events.to_json
  end

  def search
    @events = Event.order("start_at").includes(:client,:professional).where("start_at >= ?", Time.zone.today)

    respond_to do |format|
      format.js
      format.json
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def new
    @event = Event.new
    @clients = @salon.clients
    @client = Client.find(params[:client]) unless params[:client].blank?
    #delay = (60 - (DateTime.now.min))%5
    if !params[:day].nil?
      @event.start_at = params[:day] + " " + DateTime.now.strftime("%H:%M") unless params[:day].nil?
      @event.start_at+=minutes.delay
    end
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @event }
    end
  end

  def easy_new
    @event = Event.new
    @clients = @salon.clients
    @client = Client.find(params[:client]) unless params[:client].blank?
    find_new_event
    respond_to do |format|
      format.html # new.html.erb
      format.js {render "/events/new"}
      format.xml  { render :xml => @event }
    end
  end

  def create
    confirm_conflicts = params[:confirm_conflicts]    
    #params[:event].delete(:confirm_conflicts)    
    @event = Event.new(params[:event])
    @event.salon = @salon    
    
    #Adding the professional to the event        
    @event.professional_id = params[:professional] || current_professional.id    
    
    #Adding the service to the event
    @event.service_id = params[:service] if params[:service] && params[:service] != ""

    #Adding the client to the event if exists
    @event.client_id = params[:client] if params[:client] && params[:client] != ""

    #Checking if it's to save the event event with conflicts    
    if confirm_conflicts == "1"
      if @event.save(:validate => false)
        conflicted_events = @event.find_conflicts
        conflicted_events.each do |e|
          e.update_attributes(:reschedule => true)
          if(e.client)
            puts "Notify client about canceled event"
            #Notifier.client_event_reschedule_notification(e).deliver
          end
          if(e.professional)   
            puts "notify professional about canceled event"
            #Notifier.professional_event__reschedule_notification(e).deliver
          end
        end
        respond_to do |format|                
          format.html { redirect_to([:admin,@event], :notice => 'Agendamento criado com sucesso') }
          format.xml  { render :xml => @event, :status => :created, :location => @event }
        end
      end
    else
      respond_to do |format|
        if @event.save
          flash[:notice] = 'Agendamento criado com sucesso!'
          format.js { render js: %(window.location.href='#{admin_event_path @event}')}
          format.html { redirect_to( [:admin, @event] ) }
          format.xml  { render :xml => @event, :status => :created, :location => @event }
        else          
          format.js do 
            #Check if there are errors            
            if @event.errors[:base].empty? || @event.errors.size > 1
              render "create_error"
            else
              render "confirm_conflicts"
            end            
          end
          format.html { render :action => "new" }
          format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def easy_create
    @event = Event.new(
      :end_at => params[:end_at], 
      :start_at => params[:start_at]
      )
    salon = @salon
    professional = salon.professionals.find(params[:professionals])
    service = professional.services.find(params[:service])
    client = salon.clients.find(params[:client])
    @event.title = service.name
    @event.description = "#{service.name} marcado(a) pelo funcionário #{current_professional.name} via internet, 
    na: #{DateTime.now.strftime("%A, %d de %B às %H:%M")}"
    @event.created_by = "Professional"
    @event.service = service
    @event.salon = salon
    @event.professional = professional
    @event.client = client
    @event.service_to_client_event = true
    respond_to do |format|
      if @event.save
        format.js
        format.html { redirect_to([:admin,@event], :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        puts @event.errors.inspect      
        format.js {render "create_error"}
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @event = Event.includes(:client,:professional,:service).find(params[:id])        
    if !params[:service] && !params[:professionals]
      @service = @event.service
      @service_professionals = @event.professional
    end
    @client = @event.client unless params[:client]
    @clients = @salon.clients    
    find_new_event    
    respond_to do |format|
      format.html
      format.js {render "/events/new"}
      format.xml  { render :xml => @event }
    end    
  end

    # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    @event.professional = @salon.professionals.find(params[:professionals])
    @event.service = @event.professional.services.find(params[:service])
    @event.client = @salon.clients.find(params[:client])
    @event.end_at = params[:end_at]
    @event.start_at = params[:start_at]
    @event.reschedule = false
    respond_to do |format|
      if @event.save        
        flash[:notice] = "Evento alterado com sucesso"
        format.html { redirect_to([:admin,@event])}
        format.xml  { head :ok }
        format.js {render "update"}
      else
        flash[:alert] = "Houve um erro ao tentar alterar seu evento"
        format.js {render :js => "window.location.reload()"}
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end


  def show
    @event = @salon.events.find(params[:id])
    respond_to do |format|
      format.html
      format.js
      format.xml  { render :xml => @event }
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    #Instead of destroying the event set it to Canceled
    #@event.destroy
    @event.update_attribute(:status,"Cancelado")

    respond_to do |format|

      if(@event.client)
        Notifier.client_event_canceled(@event).deliver
      end
      if(@event.professional)   
        Notifier.professional_event_canceled(@event).deliver
      end

      flash[:notice] = "Evento cancelado com sucesso!"
      format.html { redirect_to(events_url) }
      format.js
      format.xml  { head :ok }
    end
  end
end
