class CreatePhones < ActiveRecord::Migration[5.1]
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :type
      t.integer :owner
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
