class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :determine_layout

  def after_sign_in_path_for(resource)
    return root_url if [new_user_session_url, new_user_registration_url].include?(request.referrer)
    
    request.referrer
  end

  def post_owner?(post:)
    post.user_id == current_user&.id
  end
  helper_method :post_owner?

  def htmx_request?
    request.headers['HX-Request'].present?
  end
  helper_method :htmx_request?

  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def determine_layout
    return false if htmx_request? && devise_controller?

    'application'
  end
end
