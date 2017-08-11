class PatientsController < ApplicationController
    def index
        @patients = Patient.all
    end

    def show
        @patient = Patient.find(params[:id])
    end

    def new
    end

    def create
        @patient = Patient.new(patient_params)

        @patient.save
        redirect_to @patient
    end

    private
        def patient_params
            params.require(:patient)
                .permit(:last_name, 
                :given_name, 
                :date_of_birth,
                :fathers_name,
                :fathers_occupation,
                :mothers_name,
                :mothers_occupation,
                :permanent_address,
                :permanent_district,
                :present_permanent_same,
                :present_address)
        end
end
