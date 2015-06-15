class TemporaryMigration < ActiveRecord::Migration
	def change
		remove_column :user_positions, :user
		drop_table :users

		add_reference :user_positions, :user_session, index: true, foreign_key: true
	end
end
