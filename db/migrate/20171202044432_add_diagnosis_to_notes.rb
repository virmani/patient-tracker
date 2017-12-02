class AddDiagnosisToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :visit_date, :date
    add_column :notes, :diagnosis, :string
    add_column :notes, :surgery, :string
  end
end
