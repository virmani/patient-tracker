class AddReferredByToPatients < ActiveRecord::Migration[5.1]
  def change
    add_reference :patients, :doctors
  end
end
