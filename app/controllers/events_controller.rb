class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  #autocomplete :professional, :nome, :full => true
  #autocomplete :client, :nome, :full => true
  before_filter :authenticate_user!

  def index
    if current_user.is_client?
      @events = current_user.events.order("start_at").includes(:professional).paginate(:per_page => 10, :page => params[:page])
    else
      @events = Event.order("start_at").includes(:client,:professional).all
      @month = params[:month] ? Date.parse(params[:month]) : Date.today
      @date = @month
      #@shown_month = Date.civil(@year, @month)
      #@event_strips = Event.event_strips_for_month(@shown_month)
    end
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

    #Se nao for cliente
    if current_user.class != Client
      @event = Event.new
      minutos = (60 - (DateTime.now.min))%5
      @event.start_at = params[:day] + " " + DateTime.now.strftime("%H:%M") unless params[:day].nil?
      @event.start_at+=minutos.minutes

    #Se for cliente
    else
      @professional = params[:professional] ? Professional.find(params[:professional]) : Professional.first
      puts @professional.inspect
      @events = Event.find(:all,:conditions => ["(start_at >= ? OR end_at >= ?) and professional_id = ?", Date.today.to_datetime, Date.today.to_datetime,@professional.id],:order => "start_at")
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    if isClient?
      @event = Event.new(:end_at => params[:end_at], :start_at => params[:start_at],:professional_id => params[:professional])
      @event.title = "Reuniao com o cliente"
      @event.description = "Reuniao marcada pelo cliente pela internet, na: #{l DateTime.now, :format => :default}"
      @event.client = current_user
    else
      @event = Event.new(params[:event])
      
      if isSecretary?
        params[:professional] ? @event.professional_id = params[:professional] : @event.professional = Professional.first
      else
        @event.professional = current_user
      end
    end
    
    
    respond_to do |format|
      if @event.save
        format.js
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        @professional = params[:professional] ? Professional.find(params[:professional]) : (current_user ? Professional.find(current_user) : Professional.first)
        puts @event.errors
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    
    if !@event.remarcavel?
      flash[:alert] = "Voce nao tem permissao para alterar esse evento."
      render :action => "edit"
      return
    end
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
        format.js
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

end