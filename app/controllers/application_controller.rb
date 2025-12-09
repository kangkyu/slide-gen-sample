class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def ensure_signed_in
    unless signed_in?
      store_request_url
      redirect_to new_session_path
    end
  end

  def ensure_signed_out
    if signed_in?
      redirect_to session[:redirect_to] ||= root_path
    end
  end

  def current_user_id
    session[:user_id]
  end

  def signed_in?
    current_user_id.present?
  end
  helper_method :signed_in?

  def current_user
    User.find current_user_id
  end
  helper_method :current_user

  def store_request_url
    session[:redirect_to] = request.url
  end
  helper_method :store_request_url

  def render_error(message, description = nil)
    render "errors/show", locals: { message: message, description: description }
  end
end
