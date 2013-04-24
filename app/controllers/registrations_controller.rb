class RegistrationsController < Devise::RegistrationsController


protected
  def after_sign_up_path_for(resource)  	
  	if resource.type == "Professional"
      redirection = professionals_events_url
    else
      redirection = events_url
    end   
    redirection
  end

end