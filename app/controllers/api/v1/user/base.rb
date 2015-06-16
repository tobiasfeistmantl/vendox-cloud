class Api::V1::User::Base < Api::V1::Base
	include Api::V1::User::SessionsHelper

	before_action :set_user_session

	protected

	def set_user_session
		if params[:session_token]
			@user_session = find_user_session_by_token(params[:session_token])

			unless @user_session
				render json: { errors: ["Invalid session token"] }, status: 404
				
				return
			end
		else
			render json: { errors: ["No session token provided"] }, status: 401

			return
		end
	end
end