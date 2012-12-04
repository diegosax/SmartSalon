#encoding: utf-8

class DashboardController < ApplicationController
	before_filter :authenticate_user!

	def index		
		@events = current_user.events.next.order(:start_at).limit(10)
		@my_salons_and_favorites = current_user.my_salons_and_favorites
	end
end
