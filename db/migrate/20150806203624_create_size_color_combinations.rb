class CreateSizeColorCombinations < ActiveRecord::Migration
  def change
    create_table :size_color_combinations do |t|
      t.references :clothing_size, index: true, foreign_key: true, null: false
      t.references :clothing_color, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
