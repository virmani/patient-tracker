class Phone < ApplicationRecord
  belongs_to :patient
  
  validates :number, presence: true, length: {minimum: 9}

  enum phone_type: [:mobile, :landline]
  enum phone_owner: [:mother, :father, :other]
end
