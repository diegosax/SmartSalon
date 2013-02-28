class Admin::DashboardController < Admin::ApplicationController
	before_filter :authenticate_professional!

	def index
		professional_id = params[:professional] ? params[:professional] : current_professional.id
		@all_today_events = Event.active.where(:start_at => Time.zone.now.at_beginning_of_day..Time.zone.now.end_of_day).order(:start_at)
		@my_today_events = @all_today_events.where(:professional_id => professional_id).order(:start_at)		
		@today_canceled_events = Event.canceled.where(:start_at => Time.zone.now.at_beginning_of_day..Time.zone.now.end_of_day).order(:start_at)
		respond_to do |format|
      		format.js
      		format.html      		
    	end
	end
end