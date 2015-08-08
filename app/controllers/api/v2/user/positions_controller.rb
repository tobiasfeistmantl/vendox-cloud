class Api::V2::User::PositionsController < Api::V2::User::Base
	before_action :set_position, only: [:show]

	def index
		@positions = @user_session.positions

		render json: @positions
	end

	def create
		@position = @user_session.positions.new user_position_params

		if @position.save
			render "create", location: api_v2_user_position_url(@position), status: 201
		else
			render json: {
				error: "UNABLE_TO_SAVE_POSITION",
				specific: @position.errors
			}, status: 400
		end
	end

	def show
		render json: @position
	end

	private

	def user_position_params
		params.require(:position).permit(:latitude, :longitude)
	end

	def set_position
		@position = @user_session.positions.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		render json: {
			error: "POSITION_NOT_FOUND"
		}, status: 404

		return
	end
end
