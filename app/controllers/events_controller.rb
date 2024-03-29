#encoding: utf-8

class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  #autocomplete :professional, :nome, :full => true
  #autocomplete :client, :nome, :full => true
  include NewEvent
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
    if !params[:service] && !params[:professionals]      
      @service = @event.service    
      @service_professionals = @event.professional
    end    
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
    @event = Event.includes(:salon).find(params[:id])
    @event.professional = @event.salon.professionals.find(params[:professionals])
    @event.service = @event.professional.services.find(params[:service])
    @event.end_at = params[:end_at]
    @event.start_at = params[:start_at]
    @event.reschedule = false
    @event.client = current_user
    respond_to do |format|
      if @event.save        
        flash[:notice] = "Evento alterado com sucesso"
        format.html { redirect_to(@event)}
        format.xml  { head :ok }
        format.js {redirect_to @event}
      else
        flash[:alert] = "Houve um erro ao tentar alterar seu evento"
        format.js {render :js => "window.location.reload()"}
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
    @mes = params[:month] || Time.zone.today
    @mes = @mes.to_datetime
    if current_user.class == Client
      @events = Event.order("start_at").joins(:client).where("client_id = ? and (start_at = ? or (start_at < ? and end_at >=?)) ",current_user.id, mes,mes,mes).includes(:professional).all
    else
      @events = Event.order("start_at").where("start_at >= ? and start_at <?", @mes,@mes.end_of_day).includes(:client,:professional)      
    end
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  

end