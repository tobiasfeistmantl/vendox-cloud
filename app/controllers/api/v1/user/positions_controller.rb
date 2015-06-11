class Api::V1::User::PositionsController < User::Base
	def index
		@positions = @user.positions

		render json: @positions
	end
end
