class Admin::ProfessionalsController < Admin::ApplicationController
	before_filter :authenticate_professional!

	def show
		@professional = current_professional		
	end
end