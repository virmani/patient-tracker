require 'pp'

class Patient < ApplicationRecord
    default_scope { order(updated_at: :desc) }

    # Update all_in_updated_order whenever a new association is added to patient model
    has_many :phones
    has_many :emails
    has_many :notes
    has_one :google_drive_folder

    validates :last_name, presence: true, length: {minimum: 2}
    validates :given_name, presence: true, length: {minimum: 2}
    validates_date :date_of_birth, presence: true, on_or_before: lambda { Date.current }    
    validates :permanent_address, presence: true, length: {minimum: 1}
    validates :permanent_district, presence: true, length: {minimum: 1}

    # def last_contact
    #     last_visit = notes.order("visit_date").first
    #     if last_visit.present?
    #         last_visit.visit_date
    #     else
    #         self.updated_at
    #     end
    # end

    # TODO: remove the custom SQL and turn this into a scope. Some info here - https://stackoverflow.com/questions/9197649/rails-sort-by-join-table-data
    def self.all_in_updated_order
        Patient.left_outer_joins(:phones, :emails, :google_drive_folder, :notes)
            .select('patients.id, patients.given_name, patients.last_name, '\
                'COALESCE(MAX(notes.visit_date), patients.updated_at) as last_contact, '\
                'patients.permanent_district, '\
                'MAX('\
                    'GREATEST(patients.updated_at, emails.updated_at, google_drive_folders.updated_at, phones.updated_at, notes.updated_at)'\
                ') AS last_updated')
            .group('patients.id, patients.given_name, patients.last_name, patients.date_of_birth, patients.permanent_district')
            .reorder('last_updated DESC')        
    end
end
