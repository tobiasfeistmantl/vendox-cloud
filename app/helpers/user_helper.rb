module UserHelper
	def current_user
		if not @user_session
			@user_session = nil

			UserSession.find_each do |user_session|
				if Devise.secure_compare(user_session.token, params[:session_token])
					@user_session = user_session
				end
			end
		end

		if not @user_session
			@user_session = UserSession.create
			session[:user_session_id] = @user_session.id
		end

		return @user_session
	end

	def user_address
		session[:user_address]
	end
end