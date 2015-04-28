class AddRemainingProductsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :remaining_products, :integer, default: 10
  end
end
