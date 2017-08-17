class PhonesController < ApplicationController
    def create
        @patient = Patient.find(params[:patient_id])
        @phone = @patient.phones.new(phone_params)

        if @phone.save
            redirect_to @patient
        else
            render 'patients/show'
        end
    end

    private
    def phone_params
        params.require(:phone).permit(:number, :phone_type, :phone_owner)
    end

end
