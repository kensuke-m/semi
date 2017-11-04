class ChargesController < ApplicationController
  before_action :set_charge, only: [:show, :edit, :update, :destroy]

  # GET /charges
  # GET /charges.json
  def index
    @charges = Charge.order(:subject_id)
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
  end

  # GET /charges/new
  def new
    @charge = Charge.new
  end

  # GET /charges/1/edit
  def edit
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = Charge.new(charge_params)

    # Create the corresponding records in recruitments when new charge is created.
    if not Recruitment.where(staff_id: charge_params[:staff_id], subject_id: charge_params[:subject_id]).exists?
      recruitment = Recruitment.new(staff_id: charge_params[:staff_id], subject_id: charge_params[:subject_id]);
      recruitment.save
    end

    # Create the corresponding records in syllabuses when new charge is created.
    if not Syllabus.where(staff_id: charge_params[:staff_id], subject_id: charge_params[:subject_id]).exists?
      syllabus = Syllabus.new(staff_id: charge_params[:staff_id], subject_id: charge_params[:subject_id]);
      syllabus.save
    end

    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charges/1
  # PATCH/PUT /charges/1.json
  def update
    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to @charge, notice: 'Charge was successfully updated.' }
        format.json { render :show, status: :ok, location: @charge }
      else
        format.html { render :edit }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    if Recruitment.where(staff_id: @charge.staff_id, subject_id: @charge.subject_id).exists?
      Recruitment.where(staff_id: @charge.staff_id, subject_id: @charge.subject_id)[0].destroy
    end

    if Syllabus.where(staff_id: @charge.staff_id, subject_id: @charge.subject_id).exists?
      Syllabus.where(staff_id: @charge.staff_id, subject_id: @charge.subject_id)[0].destroy
    end

    @charge.destroy
    respond_to do |format|
      format.html { redirect_to charges_url, notice: 'Charge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
      Charge.import(params[:file])
      redirect_to charges_url, notice: "Charges imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charge
      @charge = Charge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def charge_params
      params.require(:charge).permit(:staff_id, :subject_id, :capacity)
    end
end
