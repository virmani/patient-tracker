class Patient < ApplicationRecord
    validates :last_name, presence: true, length: {minimum: 2}
    validates :given_name, presence: true, length: {minimum: 2}
    validates_date :date_of_birth, presence: true, on_or_before: lambda { Date.current }    
    validates :permanent_address, presence: true, length: {minimum: 5}
    validates :permanent_district, presence: true, length: {minimum: 5}
end
