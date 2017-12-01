class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize
  before_action :arrange

  rescue_from ActiveRecord::RecordNotFound, with: :not_found 
#  rescue_from Exception, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def raise_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def not_found
    respond_to do |format|
      format.html { redirect_to top_index_url and return}
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  def error
    respond_to do |format|
      format.html { redirect_to top_index_url }
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  protected

  def arrange
    if session[:user_name]
      @syllabus_links = Hash.new
      @request_counts = Hash.new
      @syllabus_links_r = Hash.new
      @overflow = Hash.new
      Subject.all.each do |subject|
        if User.grade(session[:user_name]) >= subject.grade
          a = Array.new
          b = Array.new
          c = Array.new
          d = Array.new
          Staff.all.order(:kana).each do |staff|
            if Charge.exists?(subject_id: subject.id, staff_id: staff.id)
              a << Syllabus.find_by(subject_id: subject.id, staff_id: staff.id).id
              b << Request.where('subject_id = ? and staff_id = ?', subject.id, staff.id).count
              if Recruitment.exists?(subject_id: subject.id, staff_id: staff.id)
                c << Syllabus.find_by(subject_id: subject.id, staff_id: staff.id).id
                d << false
              else
                d << true
              end
            end
          end
          @syllabus_links[subject.id] = a unless a.empty?
          @request_counts[subject.id] = b unless b.empty?
          @syllabus_links_r[subject.id] = c unless c.empty?
          @overflow[subject.id] = d unless d.empty?
        end
      end
    end
    session[:status] = File.read("#{Rails.root}/config/status.txt").to_i
    Thread.current[:status] = session[:status]
    Thread.current[:user_name] = session[:user_name]
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
