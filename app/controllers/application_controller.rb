class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :current_user

  protected
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate
    logged_in? || access_denied
  end

  def logged_in?
    current_user.is_a? User
  end

  def access_denied
    redirect_to login_path, notice: "Please log in to continue" and return false
  end
end
