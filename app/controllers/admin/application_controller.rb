class Admin::ApplicationController < ActionController::Base
	layout 'admin/application'
	before_filter :load_salon
	rescue_from CanCan::AccessDenied do |e|
		Rails.logger.debug "Access denied on #{e.action} #{e.subject.inspect}"
    	redirect_to :admin_root, :alert => e.message
  	end

	#before_filter :check_logged

	def check_logged
		if (current_user)
			redirect_to root_url
		end
	end

	def load_salon
		@salon = params[:salon_id]
	end

	def current_ability
  		@current_ability ||= Ability.new(current_user || current_professional)
	end
end