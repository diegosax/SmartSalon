class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
  	if (resource.is_a?(Client))
      return events_url
    elsif (resource.is_a?(Professional))
      return professionals_events_url
    end
  end
end