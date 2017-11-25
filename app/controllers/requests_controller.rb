class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_request

  # GET /requests
  # GET /requests.json
  def index
    if User.admin?(session[:user_name])
      @requests = Request.all
    else
      if session[:staff_id]
        @requests = Request.where("staff_id = ?", session[:staff_id]).order(:subject_id)
      else
        if User.student?(session[:user_name])
          @requests = Request.where("studentusername = ?", session[:user_name])
        end
      end
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    if User.admin?(session[:user_name]) or ((session[:status] == 3 or session[:status] == 5) and User.student?(session[:user_name]))
      if Request.where("subject_id = ? and studentusername = ?", params[:subject_id], params[:studentusername]).any?
        redirect_to requests_url, alert: "#{Subject.find(params[:subject_id]).name}の配属希望は提出済みです．変更したいときは提出済みのものを削除してください．"
      else
        if Recruitment.where("subject_id = ? and staff_id = ?", params[:subject_id], params[:staff_id]).any?
          @request = Request.new(subject_id: params[:subject_id], staff_id: params[:staff_id], studentusername: params[:studentusername])
        else
          redirect_to requests_url, alert: "#{Subject.find(params[:subject_id]).name}の#{Staff.find(params[:staff_id]).lastname}ゼミは募集していません．"
        end
      end
    else
      redirect_to top_index_url, alert: '今は配属希望を提出できません'
    end
  end

  # GET /requests/1/edit
  def edit
    if not User.admin?(session[:user_name]) and @request.staff.username != session[:user_name] and @request.studentusername != session[:user_name]
      redirect_to top_index_url, alert: '権限のない配属希望を編集しようとしました'
    else
      unless ((session[:status] == 3 or session[:status] == 5) and User.student?(session[:user_name])) or ((session[:status] == 4 or session[:status] == 6) and User.staff?(session[:user_name]))
        redirect_to top_index_url, alert: '今は配属希望を編集できません'
      end
    end
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: '配属希望が提出されました' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    if not User.admin?(session[:user_name]) and @request.staff.username != session[:user_name] and @request.studentusername != session[:user_name]
      redirect_to top_index_url, alert: '権限のない配属希望を更新しようとしました'
    else
      unless ((session[:status] == 3 or session[:status] == 5) and User.student?(session[:user_name])) or ((session[:status] == 4 or session[:status] == 6) and User.staff?(session[:user_name]))
        redirect_to top_index_url, alert: '今は配属希望を更新できません'
      end
    end
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: "#{@request.studentusername}さんの#{@request.subject.name}の配属希望を更新しました．" }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    if not User.admin?(session[:user_name]) and @request.staff.username != session[:user_name] and @request.studentusername != session[:user_name]
      redirect_to top_index_url, alert: '権限のない配属希望を削除しようとしました'
    else
      unless (session[:status] == 3 or session[:status] == 5) and User.student?(session[:user_name])
        redirect_to top_index_url, alert: '今は配属希望を削除できません'
      end
    end
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: '配属希望を削除しました' }
      format.json { head :no_content }
    end
  end

  # Show the list of requests
  def show_list
    if params[:staff_id] == '*'
      @requests = Request.where(subject_id: params[:subject_id]).order("#{sort_column} #{sort_direction}")
    else
      @requests = Request.where(subject_id: params[:subject_id], staff_id: params[:staff_id]).order("#{sort_column} #{sort_direction}")
    end
    @subject_id = params[:subject_id]
    @staff_id = params[:staff_id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:subject_id, :staff_id, :studentusername, :studentname, :reason, :permission, :column, :direction)
    end

    def invalid_request
      logger.error "Attempt to access invalid request #{params[:id]}"
      redirect_to top_index_url, alert: "存在しない配属希望にアクセスしました"
    end

    def sortable_columns
      ["subject", "staff", "studentusername", "permission"]
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
