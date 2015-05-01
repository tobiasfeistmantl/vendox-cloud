class AddPriceOnRequestToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price_on_request, :boolean
  end
end
