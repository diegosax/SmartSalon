class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout

  def go_to_root(resource)
    if (resource.is_a?(Client))
      return events_url
    elsif (resource.is_a?(Professional))
      return professionals_events_url
    end
  end

  def after_sign_in_path_for(resource)
    go_to_root(resource)
  end

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? false : "application"
  end  
end
