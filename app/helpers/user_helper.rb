module UserHelper
	def current_user
		if session[:session_token]
			if @user_session
				return @user_session
			else
				UserSession.find_each do |user_session|
					if Devise.secure_compare(user_session.token, params[:session_token])
						@user_session = user_session
					end
				end
			end
		end
	end

	def user_address
		session[:user_address]
	end
end