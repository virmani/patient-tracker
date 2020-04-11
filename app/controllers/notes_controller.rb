class NotesController < ApplicationController
  def index
    @patient = Patient.find(params[:patient_id])
    redirect_to @patient
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @note = @patient.notes.new(note_params)
    if @note.save
      redirect_to @patient
    else
      render 'patients/show'
    end
  end

  def edit
    @patient = Patient.find(params[:patient_id])
    @note = @patient.notes.find(params[:id])

  end

  def update
    @patient = Patient.find(params[:patient_id])
    @note = @patient.notes.find(params[:id])
    if @note.update(note_params)
      redirect_to @patient
    else
      render "edit"
    end
  end

  def diagnoses
    @diagnoses = Note.pluck(:diagnosis).uniq.reject { |item| (item == nil || item.empty?) }
    respond_to do |format|
        format.json { render json: @diagnoses}
    end
  end

  def surgeries
    @surgeries = Note.pluck(:surgery).uniq.reject { |item| (item == nil || item.empty?) }
    respond_to do |format|
        format.json { render json: @surgeries}
    end
  end

  def search
    @entry = Note.pluck(:patient_id, :diagnosis)
    respond_to do |format|
      format.json { render json: @entry }
    end
  end

  private
  
  def note_params
    params.require(:note).permit(
      :visit_date, 
      :note,
      :diagnosis,
      :surgery)
  end

end