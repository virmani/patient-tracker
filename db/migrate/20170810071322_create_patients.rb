class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :last_name, null: false
      t.string :given_name, null: false
      t.date :date_of_birth, null: false
      t.string :fathers_name
      t.string :fathers_occupation
      t.string :mothers_name
      t.string :mothers_occupation
      t.text :permanent_address, null: false
      t.string :permanent_district, null: false
      t.boolean :present_permanent_same
      t.text :present_address

      t.timestamps
    end
  end
end
