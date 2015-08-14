class Api::V2::User::SessionsController < Api::V2::User::Base
	before_action :set_user_session, except: [:create]
	before_action :authenticate_with_token!, except: [:create]

	def create
		if not params[:session].present? && params[:session][:device].present?
			render json: {
				error: {
					type: "PARAMETER_IS_MISSING",
					specific: "session[device]"
				}
			}, status: 400
			return
		end

		@user_session = ::UserSession.new device: params[:session][:device]

		if @user_session.save
			render json: @user_session, location: api_v2_user_session_url(@user_session), status: 201
		else
			render json: {
				error: {
					type: "UNABLE_TO_SAVE_USER_SESSION",
					specific: @user_session.errors
				}
			}, status: 400
		end
	end

	def show
		render json: @user_session
	end
end
