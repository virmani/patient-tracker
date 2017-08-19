class ChangeEmailColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :emails, :owner, :email_owner    
  end
end
