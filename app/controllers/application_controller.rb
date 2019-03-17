class ApplicationController < ActionController::Base

  helper_method :current_user

  def logged_in_user!
    redirect_to new_user_url if current_user.nil?
  end

  def log_in!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_out!
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def only_current_user
    redirect_to new_user_url if current_user.nil?
  end
end
