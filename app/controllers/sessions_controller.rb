class SessionsController < ApplicationController
  before_action :ensure_signed_out, only: [:new, :auth]
  before_action :ensure_signed_in, only: :destroy
  before_action :set_email, only: :auth

  def new
  end

  def destroy
    session[:user_id] = nil
    session[:redirect_to] = nil
    redirect_to new_session_url
  end

  def auth
    google_auth = request.env["omniauth.auth"]
    user = User.find_or_initialize_by email_address: @email
    user.refresh_token = google_auth.credentials.refresh_token if google_auth.credentials.refresh_token.present?
    user.access_token = google_auth.credentials.token

    if user.save
      session[:user_id] = user.id
      redirect_to session.fetch :redirect_to, root_url
    else
      render_error user.errors.full_messages.to_sentence
    end
  end

  def failure
    render_error params[:message]
  end

  private

  def set_email
    @email = request.env["omniauth.auth"].info[:email]
  end
end
