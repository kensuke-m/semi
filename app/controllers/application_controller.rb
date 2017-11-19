class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize
  before_action :arrange

  protected

  def arrange
    if session[:user_name]
      @h = Hash.new
      Subject.all.each do |subject|
        if User.grade(session[:user_name]) >= subject.grade
          a = Array.new
          Recruitment.where(subject_id: subject.id).each do |recruitment|
            a << Syllabus.find_by(staff_id: recruitment.staff.id, subject_id: subject.id).id
          end
          @h[subject.name] = a unless a.empty?
        end
      end
    end
    session[:status] = File.read("#{Rails.root}/status.txt").to_i
    Thread.current[:status] = session[:status]
  end

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
