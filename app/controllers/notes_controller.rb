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

  private
  
  def note_params
    params.require(:note).permit(:note)
  end

end