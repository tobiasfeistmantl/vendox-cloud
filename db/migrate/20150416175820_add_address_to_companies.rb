class AddAddressToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :street, :string
    add_column :companies, :zip_code, :string
    add_column :companies, :locality, :string
  end
end
