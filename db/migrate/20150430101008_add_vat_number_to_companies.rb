class AddVatNumberToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :vat_number, :string
	add_index :companies, :vat_number, unique: true
  end
end
