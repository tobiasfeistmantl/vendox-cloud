class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.string :token
      t.string :device

      t.timestamps null: false
    end

    add_index :user_sessions, :token, unique: true
  end
end
