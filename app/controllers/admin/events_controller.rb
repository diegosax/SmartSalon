class Admin::EventsController < Admin::ApplicationController
  before_filter :authenticate_professional!

	def index
		@events = Event.order("start_at").includes(:client,:professional).all
		@month = params[:month] ? Date.parse(params[:month]) : Date.today
		@date = @month
    @event = Event.new
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

    def new
  		@event = Event.new
  		delay = (60 - (DateTime.now.min))%5
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

  def create
    @event = Event.new(params[:event])    
    puts "PARAMS PROFESSIONAL: #{params[:professional]}"
    if params[:professional] 
      @event.professional_id = params[:professional]
    else
      @event.professional = current_professional
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

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html {render :layout => false}
      format.js
      format.xml  { render :xml => @event }
    end
  end
end