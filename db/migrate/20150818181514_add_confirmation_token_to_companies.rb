class AddConfirmationTokenToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :confirmation_token, :string
  end
end
