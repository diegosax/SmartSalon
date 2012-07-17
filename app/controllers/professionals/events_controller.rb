class Professionals::EventsController < EventsController
	def index
		@events = Event.order("start_at").includes(:client,:professional).all
		@month = params[:month] ? Date.parse(params[:month]) : Date.today
		@date = @month
    @event = Event.new
		respond_to do |format|
			format.js
      		format.html # index.html.erb
      		format.xml  { render :xml => @events }
      	end
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
    if params[:professional] 
      @event.professional_id = params[:professional]
    else
      @event.professional = current_user
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