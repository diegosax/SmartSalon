class Admin::ApplicationController < ActionController::Base
	layout 'admin/application'
	before_filter :authenticate_professional!, :except => [:check_logged]
	before_filter :load_salon
	after_filter :flash_to_headers
	rescue_from CanCan::AccessDenied do |e|
		Rails.logger.debug "Access denied on #{e.action} #{e.subject.inspect}"
    	respond_to do |format|
    		flash[:alert] = e.message
    		format.html {redirect_to :back}
    		format.js {render :js => "window.location = '#{admin_root_path}'"}
    	end
    	
  	end

	#before_filter :check_logged


	def flash_to_headers
	  return unless request.xhr?	  	        
        response.headers['X-Message'] = flash_message
        response.headers["X-Message-Type"] = flash_type.to_s    	
        flash.discard # don't want the flash to appear when you reload page
	end

	def check_logged
		if (current_user)
			redirect_to root_url
		end
	end

	def load_salon
		@salon = current_professional.salon if current_professional
	end

	def current_ability		
  		@current_ability ||= AdminAbility.new(current_professional)
	end

	def extract_salon_from_moip_id(id)
		ids = id.split("-")
		if ids.size > 0
			return ids[0]
		else
			return 0
		end
	end

	def extract_subscription_from_moip_id(id)
		ids = id.split("-")
		if ids.size > 1
			return ids[1]
		else
			return 0
		end
	end

	def extract_payment_from_moip_id(id)
		ids = id.split("-")
		if ids.size > 2
			return ids[2]
		else
			return 0
		end
	end
private
	def flash_message
        [:error, :warning, :notice].each do |type|
            return flash[type] unless flash[type].blank?
        end                
        return ''
    end

    def flash_type
        [:error, :warning, :notice].each do |type|
            return type unless flash[type].blank?
        end
        return ''
    end
end