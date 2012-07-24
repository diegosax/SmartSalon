class Admin::SessionsController < Devise::SessionsController
	
	def new
		@professional = Professional.new
		resource = build_resource(nil, :unsafe => true)
		clean_up_passwords(resource)
		respond_with(resource, serialize_options(resource))
	end

	def go_to_root(resource)
		if (resource.is_a?(Client))
			return events_url
		elsif (resource.is_a?(Professional))
			return admin_events_url
		end
	end

	def after_sign_in_path_for(resource)
		go_to_root(resource)
	end

end