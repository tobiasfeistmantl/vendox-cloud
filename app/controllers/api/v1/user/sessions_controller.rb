class Api::V1::User::SessionsController < Api::V1::User::Base
	protect_from_forgery :except => :create

	before_action :set_user_session, only: [:show]

	def create
		@user_session = ::UserSession.new device: params[:device]

		if @user_session.save
			respond_with @user_session, location: api_v1_user_session_url(@user_session.token)
		else
			render json: { errors: @user_session.errors.full_messages }, status: 400
		end
	end

	def show
		respond_with @user_session
	end
end
