module Api::V2::User::SessionsHelper
	def find_user_session_by_token(token)
		if token
			UserSession.find_each do |user_session|
				if Devise.secure_compare(user_session.token, token)
					return user_session
				end
			end
		end
	end

	def current_user_session(create_if_nil: false)
		if cookies[:session_token].present?
			if @user_session.present?
				return @user_session
			else
				UserSession.find_each do |user_session|
					if Devise.secure_compare(user_session.token, cookies[:session_token])
						@user_session = user_session
					end
				end
			end
		end

		if @user_session.nil? && create_if_nil
			@user_session = UserSession.create(device: request.env["HTTP_USER_AGENT"])
			cookies[:session_token] = @user_session.token
		end

		return @user_session
	end
end
