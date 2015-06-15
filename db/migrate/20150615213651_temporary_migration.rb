class TemporaryMigration < ActiveRecord::Migration
	def change
		drop_table :users

		add_reference :user_positions, :user_session, index: true, foreign_key: true
	end
end
