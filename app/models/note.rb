class Note < ApplicationRecord
  default_scope { order(updated_at: :desc) }
  belongs_to :patient
  validates :visit_date, presence: true
  validates :note, presence: { :unless => lambda {:diagnosis? || :surgery?} }
end