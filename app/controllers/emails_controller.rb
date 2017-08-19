class EmailsController < ApplicationController
    def index
        @patient = Patient.find(params[:patient_id])
        redirect_to @patient
    end

    def create
        @patient = Patient.find(params[:patient_id])
        @email = @patient.emails.new(email_params)

        if @email.save
            redirect_to @patient
        else
            render 'patients/show'
        end
    end

    def destroy
        @patient = Patient.find(params[:patient_id])
        @email = @patient.emails.find(params[:id])
        @email.destroy

        redirect_to @patient
    end

    private
    def email_params
        params.require(:email).permit(:email_address, :email_owner)
    end
end
