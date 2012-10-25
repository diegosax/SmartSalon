class Admin::ApplicationController < ActionController::Base
	layout 'admin/application'
	before_filter :load_salon
	rescue_from CanCan::AccessDenied do |e|
		Rails.logger.debug "Access denied on #{e.action} #{e.subject.inspect}"
    	respond_to do |format|
    		flash[:alert] = e.message
    		format.html {redirect_to :back}
    		format.js {render :js => "window.location = '#{admin_root_path}'"}
    	end
    	
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
		puts "SETTING THE CURRENT ABILITYYYYYYYYYYYYYYYYYYYYYY"
  		@current_ability ||= AdminAbility.new(current_professional)
	end
end