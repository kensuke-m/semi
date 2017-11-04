class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  protected

  def authorize
    unless session[:user_name]
      redirect_to signin_url
    end
  end

  def admin
    authorize
    unless User::admin?(session[:user_name])
      redirect_to top_index_url
    end
  end
end
