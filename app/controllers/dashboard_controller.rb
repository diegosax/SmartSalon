#encoding: utf-8

class DashboardController < ApplicationController
	before_filter :authenticate_user!

	def index		
		@events = current_user.events.next.order(:start_at).limit(10)		
	end
end
