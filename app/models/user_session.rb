class UserSession < ActiveRecord::Base
	before_save :generate_unique_secure_token

	has_many :positions, class_name: "UserPosition"

	validates :token, uniqueness: true
	validates :device, presence: true

	def coordinates
		@current_position ||= positions.last

		if @current_position
			[@current_position.latitude, @current_position.longitude]
		end
	end

	def position
		if last_position = positions.last
			last_position
		end
	end

	private

	def generate_unique_secure_token
		unless self.token
			token = SecureRandom.urlsafe_base64

			self.token = token
		end
	end
end
