class AddLongitudeLatitudeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :longitude, :float
    add_column :products, :latitude, :float
  end
end
