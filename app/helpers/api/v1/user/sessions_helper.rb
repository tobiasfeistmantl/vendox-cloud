module Api::V1::User::SessionsHelper
	def find_user_session_by_token(token)
		if token
			UserSession.find_each do |user_session|
				if Devise.secure_compare(user_session.token, token)
					return user_session
				end
			end
		end
	end
end
