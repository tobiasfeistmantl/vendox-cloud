class Api::V2::User::Base < Api::V2::Base
	include Api::V2::User::SessionsHelper

	protected

	def set_user_session
		@user_session = UserSession.find(params[:id])

		authenticate_with_token
	rescue ActiveRecord::RecordNotFound
		render json: { errors: [ "User session not found" ] }, status: 404
		return
	end

	def authenticate_with_token
		if request.authorization && session_token = token_and_options(request)[0]
			unless Devise.secure_compare(@user_session.token, session_token)
				render json: { errors: [ "Invalid session token" ] }, status: 403
				return
			end
		else
			render json: { errors: [ "No session token provided" ] }, status: 401
			return
		end
	end

	def set_user_session_with_token
		if request.authorization && session_token = token_and_options(request)[0]
			@user_session = find_user_session_by_token(session_token)

			unless @user_session
				render json: { errors: [ "User session not found" ] }, status: 401
			end
		else
			render json: { errors: [ "No session token provided" ] }, status: 401
			return
		end
	end
end