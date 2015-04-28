class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.float :longitude
      t.float :latitude
      t.string :address
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
