class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
  	puts resource.inspect
  	if resource.type == "Professional"
      redirection = professionals_events_url
  	else
  	  redirection = events_url
    end
    puts "REDIRECTION:::::::::::::: #{redirection} - #{resource.type}"
    redirection
  end
end