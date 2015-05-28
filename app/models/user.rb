class User < ActiveRecord::Base
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
end
