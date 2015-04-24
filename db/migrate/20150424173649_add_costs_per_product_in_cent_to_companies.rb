class AddCostsPerProductInCentToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :costs_per_product_in_cent, :integer
  end
end
