class Phone < ApplicationRecord
  belongs_to :patient
  
  validates :number, presence: true, length: {minimum: 9}

  phony_normalize :number, default_country_code: 'IN'

  validates :number, phony_plausible: true

  enum phone_type: [:mobile, :landline]
  enum phone_owner: [:mother, :father, :other]
end
