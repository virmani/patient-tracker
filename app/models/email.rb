class Email < ApplicationRecord
    belongs_to :patient  
    validates :email_address, presence: true, email: true
    enum email_owner: [:self, :mother, :father, :other]
  end
