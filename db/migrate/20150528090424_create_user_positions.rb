class CreateUserPositions < ActiveRecord::Migration
  def change
    create_table :user_positions do |t|
      t.references :user_session, index: true, foreign_key: true
      t.float :longitude
      t.float :latitude

      t.timestamps null: false
    end
  end
end
