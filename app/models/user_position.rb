class UserPosition < ActiveRecord::Base
	belongs_to :user

	def expired?
		if created_at < Time.now - 20.minutes
			true
		else
			false
		end
	end
end