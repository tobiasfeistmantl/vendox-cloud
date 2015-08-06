class AddClothesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :clothes, :boolean, default: false, null: false
  end
end
