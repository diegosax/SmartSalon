class Admin::ApplicationController < ActionController::Base
	layout 'admin/application'
	before_filter :load_salon

	#before_filter :check_logged

	def check_logged
		if (current_user)
			redirect_to root_url
		end
	end

	def load_salon
		@salon = params[:salon_id]
	end
end