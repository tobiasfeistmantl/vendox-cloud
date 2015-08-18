class ModifyForOwnAuthenticationSystem < ActiveRecord::Migration
	def change
		change_table :companies do |t|
			t.remove :reset_password_token
			t.remove :reset_password_sent_at
			t.remove :remember_created_at
			t.remove :sign_in_count
			t.remove :current_sign_in_at
			t.remove :last_sign_in_at
			t.remove :current_sign_in_ip
			t.remove :last_sign_in_ip
			t.remove :confirmation_token
			t.remove :confirmed_at
			t.remove :confirmation_sent_at
			t.remove :unconfirmed_email
		end

		rename_column :companies, :encrypted_password, :password_digest
	end
end
