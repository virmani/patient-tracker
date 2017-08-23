class GoogleDriveFoldersController < ApplicationController
    def index
        @patient = Patient.find(params[:patient_id])
        redirect_to @patient
    end

    def create
        @patient = Patient.find(params[:patient_id])
        @gfolder = @patient.build_google_drive_folder(google_drive_folder_params)

        if @gfolder.save
            redirect_to @patient
        else
            render 'patients/show'
        end
    end

    def destroy
        @patient = Patient.find(params[:patient_id])
        @gfolder = @patient.google_drive_folder
        @gfolder.destroy

        redirect_to @patient
    end

    private
    def google_drive_folder_params
        params.require(:google_drive_folder).permit(:google_id)
    end
end
