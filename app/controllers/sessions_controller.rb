class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    user = User::authenticate(params[:name], params[:password])
    if user
      session[:user_name] = user.name
      if User::staff?(user.name)
        staff = Staff::find_by_username(user.name)
        session[:staff_id] = staff.id
        session[:staff_lastname] = staff.lastname
      end
      redirect_to top_index_url, notice: "#{t(:welcome)} #{user.name}"
    else
      redirect_to signin_url, alert: t(:upmismatch)
    end
  end

  def destroy
    session[:user_name] = nil
    session[:staff_id] = nil
    session[:staff_lastname] = nil
    redirect_to top_index_url, notice: t(:signout)
  end
end
