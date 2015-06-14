class Api::V1::User::PositionsController < Api::V1::User::Base
	protect_from_forgery :except => :create

	before_action :set_position, only: [:show]

	def index
		@positions = @user.positions

		respond_with @positions
	end

	def create
		@position = @user.positions.new user_position_params

		if @position.save
			respond_with @position, location: api_v1_user_position_url(@user.token, @position)
		else
			render json: { errors: @position.errors.full_messages }, status: 400
		end
	end

	def show
		respond_with @position
	end

	private

	def user_position_params
		params.require(:position).permit(:latitude, :longitude)
	end

	def set_position
		@position = @user.positions.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		respond_with "Not found", status: 404

		return
	end
end