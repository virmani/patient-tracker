class PhonesController < ApplicationController
    def index
        @patient = Patient.find(params[:patient_id])
        redirect_to @patient
    end

    def create
        @patient = Patient.find(params[:patient_id])
        @phone = @patient.phones.new(phone_params)

        if @phone.save
            redirect_to @patient
        else
            render 'patients/show'
        end
    end

    def destroy
        @patient = Patient.find(params[:patient_id])
        @phone = @patient.phones.find(params[:id])
        @phone.destroy

        redirect_to @patient
    end

    private
    def phone_params
        params.require(:phone).permit(:number, :phone_type, :phone_owner)
    end

end
