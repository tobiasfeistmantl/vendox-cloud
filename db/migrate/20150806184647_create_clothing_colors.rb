class CreateClothingColors < ActiveRecord::Migration
  def change
    create_table :clothing_colors do |t|
      t.references :clothing_size, index: true, foreign_key: true
      t.string :color
      t.string :hex_code
      t.integer :price_in_cent

      t.timestamps null: false
    end
  end
end
