class Api::V2::User::SessionsController < Api::V2::User::Base
	protect_from_forgery :except => :create

	before_action :set_user_session_with_token, only: [:show]

	def create
		@user_session = ::UserSession.new device: params[:device]

		if @user_session.save
			render json: @user_session, location: api_V2_user_session_url(@user_session.token), status: 201
		else
			render json: { errors: @user_session.errors }, status: 400
		end
	end

	def show
		render json: @user_session
	end
end
