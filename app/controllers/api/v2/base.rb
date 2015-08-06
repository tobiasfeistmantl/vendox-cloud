class Api::V2::Base < Api::Base
	before_action :set_user_session
	before_action :authenticate_with_token!

	protected

	def set_user_session
		@user_session = UserSession.find(params[:user_session_id])
	rescue ActiveRecord::RecordNotFound
		render json: { error: "USER_SESSION_NOT_FOUND" }, status: 404
		return
	end

	def authenticate_with_token!
		if request.authorization && session_token = token_and_options(request)[0]
			unless Devise.secure_compare(@user_session.token, session_token)
				render json: { error: "INVALID_USER_SESSION_TOKEN_COMBINATION" }, status: 401
				return
			end
		else
			render json: { error: "SESSION_TOKEN_NOT_PROVIDED" }, status: 401
			return
		end
	end
end