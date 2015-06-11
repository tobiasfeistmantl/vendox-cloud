class Api::V1::User::UsersController < User::Base
	protect_from_forgery :except => :create

	respond_to :json

	before_action :set_user, only: [:show]

	def create
		@user = User.new

		if @user.save
			render json: @user
		else
			render nothing: true
		end
	end

	def show
		render json: @user
	end

	def set_user
		@user = User.find_by(token: params[:token])

		unless @user
			respond_with "Not Found", status: 404

			return
		end
	end
end
