#encoding: utf-8

class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  #autocomplete :professional, :nome, :full => true
  #autocomplete :client, :nome, :full => true
  before_filter :authenticate_user!

  def index    
    @events = current_user.events.order("start_at").includes(:professional)#.paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    find_new_event
    
    respond_to do |format|
      format.html
      format.js
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.includes(:salon,:professional,:service).find(params[:id])    
    @salon = @event.salon
    @services = @salon.services
    @service = @event.service
    @professionals = @service.professionals
    @service_professionals = @event.professional
    

    find_new_event
    respond_to do |format|
      format.html
      format.js {render "new"}
      format.xml  { render :xml => @event }
    end    
  end

  # POST /events
  # POST /events.xml
  def create
    @event = current_user.events.new(
      :end_at => params[:end_at], 
      :start_at => params[:start_at]
      )
    salon = Salon.find(params[:salon_id])
    professional = salon.professionals.find(params[:professionals])
    service = professional.services.find(params[:service])        
    @event.title = service.name
    @event.description = "#{service.name} marcado(a) pelo cliente via internet, 
    na: #{DateTime.now.strftime("%A, %d de %B às %H:%M")}"
    @event.created_by = "Client"
    @event.service = service
    @event.salon = salon
    @event.professional = professional
    respond_to do |format|
      if @event.save
        format.js
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        puts @event.errors.inspect        
        format.js {render "create_error"}
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])    
    @event.professional = Professional.find(params[:professionals])
    @event.end_at = params[:end_at]
    @event.start_at = params[:start_at]
    @event.reschedule = false
    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
        format.js :notice => "Evento alterado com sucesso"
      else
        format.js
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.js
      format.xml  { head :ok }
    end
  end

  def dayevents
    @mes = params[:month] || Date.today
    @mes = @mes.to_datetime
    if current_user.class == Client
      @events = Event.order("start_at").joins(:client).where("client_id = ? and (start_at = ? or (start_at < ? and end_at >=?)) ",current_user.id, mes,mes,mes).includes(:professional).all
    else
      @events = Event.order("start_at").where("start_at >= ? and start_at <?", @mes,@mes.end_of_day).includes(:client,:professional)
      #@month = params[:month] ? Date.parse(params[:month]) : Date.today
      #@shown_month = Date.civil(@year, @month)
      #@event_strips = Event.event_strips_for_month(@shown_month)
    end
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  private
  def find_new_event    
    if params[:salon_id].present?
      @salon = Salon.find(params[:salon_id])
      @services = @salon.services
      if params[:service]
        @service = @salon.services.find(params[:service])
        if !params[:professionals].blank?
          if params[:professionals] == "any"
            @service_professionals = @service.professionals
          else
            @service_professionals = @salon.professionals.find(params[:professionals])
          end                      
        end
        @professionals = @service.professionals   
      end
    else
      @my_salons_and_favorites = current_user.my_salons_and_favorites if current_user
    end

    if @service_professionals && @salon
      @events = Event.find(
        :all,
        :conditions => ["
          (start_at >= ? OR end_at >= ?) AND professional_id in (?)", 
          Date.today.to_datetime, 
          Date.today.to_datetime, 
          @service_professionals
          ],
          :order => "start_at")
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
    end

    
  end

end