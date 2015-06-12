class Api::V1::User::UsersController < Api::V1::User::Base
	protect_from_forgery :except => :create

	before_action :set_user, only: [:show]

	def create
		@user = User.new

		if @user.save
			respond_with @user, location: api_v1_user_url(@user.token)
		else
			render json: { errors: @user.errors.full_messages }, status: 400
		end
	end

	def show
		respond_with @user
	end
end
