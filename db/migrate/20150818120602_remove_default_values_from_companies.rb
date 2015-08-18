class RemoveDefaultValuesFromCompanies < ActiveRecord::Migration
  def change
  	change_column_default :companies, :email, nil
  	change_column_default :companies, :password_digest, nil
  end
end
