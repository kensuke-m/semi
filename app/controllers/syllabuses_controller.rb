class SyllabusesController < ApplicationController
  before_action :set_syllabus, only: [:show, :edit, :update, :destroy]
  before_action :admin, only: [:new, :create, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_syllabus

  # GET /syllabuses
  # GET /syllabuses.json
  def index
    if User.admin?(session[:user_name])
      @syllabuses = Syllabus.all
    else
      if session[:staff_id]
        @syllabuses = Syllabus.where(staff_id: session[:staff_id])
      else
      end
    end
  end

  # GET /syllabuses/1
  # GET /syllabuses/1.json
  def show
    syllabus = Syllabus.find(params[:id])
    @requestable = false
    @requestable = true if (session[:status] == 3 or session[:status] == 5) and Recruitment.where('staff_id = ? and subject_id = ?', syllabus.staff_id, syllabus.subject_id).any? and User.student?(session[:user_name])
  end

  # GET /syllabuses/new
  def new
    @syllabus = Syllabus.new
  end

  # GET /syllabuses/1/edit
  def edit
    if not User.admin?(session[:user_name]) and @syllabus.staff.username != session[:user_name]
      redirect_to top_index_url, alert: '権限のないシラバスを編集しようとしました'
    end
  end

  # POST /syllabuses
  # POST /syllabuses.json
  def create
    @syllabus = Syllabus.new(syllabus_params)

    respond_to do |format|
      if @syllabus.save
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully created.' }
        format.json { render :show, status: :created, location: @syllabus }
      else
        format.html { render :new }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /syllabuses/1
  # PATCH/PUT /syllabuses/1.json
  def update
    if not User.admin?(session[:user_name]) and @syllabus.staff.username != session[:user_name]
      redirect_to top_index_url, alert: '権限のないシラバスを更新しようとしました'
    end
    respond_to do |format|
      if @syllabus.update(syllabus_params)
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully updated.' }
        format.json { render :show, status: :ok, location: @syllabus }
      else
        format.html { render :edit }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syllabuses/1
  # DELETE /syllabuses/1.json
  def destroy
    if not User.admin?(session[:user_name]) and @syllabus.staff.username != session[:user_name]
      redirect_to top_index_url, alert: '権限のないシラバスを削除しようとしました'
    end
    @syllabus.destroy
    respond_to do |format|
      format.html { redirect_to syllabuses_url, notice: 'Syllabus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
      Syllabus.import(params[:file], params[:id])
      redirect_to syllabus_path(params[:id]), notice: "シラバスが読み込まれました"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_syllabus
      @syllabus = Syllabus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def syllabus_params
      params.require(:syllabus).permit(:staff_id, :subject_id, :subtitle, :goal, :abstract, :plan, :evaluationmethod, :textbook, :referencebook, :selectionmethod, :remarks)
    end

    def invalid_syllabus
      logger.error "Attempt to access invalid syllabus #{params[:id]}"
      redirect_to top_index_url, alert: "存在しないシラバスにアクセスしました"
    end
end
