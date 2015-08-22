class AddPasswordResetTokenToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :password_reset_token, :string
  end
end
