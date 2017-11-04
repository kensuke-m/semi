class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to top_index_url, notice: "#{t(:welcome)} #{user.name}"
    else
      redirect_to signin_url, alert: t(:upmismatch)
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to top_index_url, notice: t(:signout)
  end
end
