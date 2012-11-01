class Admin::DashboardController < Admin::ApplicationController
	before_filter :authenticate_professional!

	def index
		@all_today_events = Event.active.where(:start_at => Time.zone.now.at_beginning_of_day..Time.zone.now.end_of_day).order(:start_at)
		@my_today_events = @all_today_events.where(:professional_id => current_professional).order(:start_at)		
		@today_canceled_events = Event.canceled.where(:start_at => Time.zone.now.at_beginning_of_day..Time.zone.now.end_of_day).order(:start_at)
	end
end