class Api::V1::User::PositionsController < Api::V1::User::Base
	protect_from_forgery :except => :create

	before_action :set_user_session_with_token
	before_action :set_position, only: [:show]

	def index
		@positions = @user_session.positions

		render json: @positions
	end

	def create
		@position = @user_session.positions.new user_position_params

		if @position.save
			render json: @position, location: api_v1_user_position_url(@position), status: 201
		else
			render json: { errors: @position.errors }, status: 400
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
		render json: { errors: [ "Position not found" ] }, status: 404

		return
	end
end
