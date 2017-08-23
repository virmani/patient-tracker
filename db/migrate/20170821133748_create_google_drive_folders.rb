class CreateGoogleDriveFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :google_drive_folders do |t|
      t.string :google_id
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
