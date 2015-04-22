class AddOrderLinkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :order_link, :string
  end
end
