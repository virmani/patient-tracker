class Email < ApplicationRecord
    belongs_to :patient  
    validates :email_address, presence: true, length: {minimum: 1}
    enum email_owner: [:self, :mother, :father, :other]
  end
