class PatientsController < ApplicationController

    http_basic_authenticate_with name: ENV["USER"], password: ENV["PASSWORD"]

    def index
        @patients = Patient.all_in_updated_order
    end

    def show
        @patient = Patient.find(params[:id])
        if @patient['doctors_id'].nil?
            @doctor = nil
        else
          @doctor=Doctor.find(@patient['doctors_id'])
        end
    end

    def districts
        @dists = Patient.pluck(:permanent_district).uniq
        respond_to do |format|
            format.json { render json: @dists}
        end
    end

    def new
        @patient = Patient.new
    end

    def edit
        @patient = Patient.find(params[:id])
    end

    def create
        doctor = Doctor.find_by(name: params[:patient]["doctors_name"])
        if(doctor.nil?)
            doctor = Doctor.new
            doctor.name=params[:patient]["doctors_name"]
            doctor.save
        end
        @patient = Patient.new(patient_params)
        @patient.doctors_id = doctor['id']
        if @patient.save
            redirect_to @patient
        else
            render 'new'
        end
    end

    def update
        @patient = Patient.find(params[:id])

        if @patient.update(patient_params)
            redirect_to @patient
        else
            render 'edit'
        end
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
