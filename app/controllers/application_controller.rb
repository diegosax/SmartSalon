class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  rescue_from CanCan::AccessDenied do |e|    
    redirect_to :back, :alert => e.message
  end

  def go_to_root(resource)
    if (resource.is_a?(Client))
      if !current_user
        sign_out :professional
        sign_in :user, resource
      end
      return root_path
    elsif (resource.is_a?(Professional))
      if !current_professional
        sign_out :user
        sign_in :professional, resource
      end
      return admin_root_path
    end
  end

  def after_sign_in_path_for(resource)
    go_to_root(resource)
  end

  def current_ability
      @current_ability ||= Ability.new(current_user || current_professional)
  end

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? false : "application"
  end  
end
