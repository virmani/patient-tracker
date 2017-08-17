class ChangePhoneColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :phones, :type, :phone_type    
    rename_column :phones, :owner, :phone_owner    
  end
end
