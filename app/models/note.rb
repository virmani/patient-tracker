class Note < ApplicationRecord
  belongs_to :patient
  validates :note, presence: true
end