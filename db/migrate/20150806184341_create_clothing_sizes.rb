class CreateClothingSizes < ActiveRecord::Migration
  def change
    create_table :clothing_sizes do |t|
      t.references :product, index: true, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
