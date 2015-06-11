class User < ActiveRecord::Base
	before_save :generate_token

	has_many :positions, class_name: "UserPosition"

	def coordinates
		@current_position ||= positions.last

		if @current_position
			[@current_position.latitude, @current_position.longitude]
		else
			nil
		end
	end

	def position
		if last_position = positions.last
			if not last_position.expired?
				last_position
			end
		end
	end

	private

	def generate_token
		if token.nil?
			self.token = SecureRandom.urlsafe_base64
		end
	end
end
