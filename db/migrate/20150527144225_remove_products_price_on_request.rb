class RemoveProductsPriceOnRequest < ActiveRecord::Migration
  def change
  	remove_column :products, :price_on_request
  end
end
