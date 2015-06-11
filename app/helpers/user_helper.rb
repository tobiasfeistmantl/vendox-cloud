module UserHelper
	def current_user
		if not @user = User.find_by(token: params[:t]) || User.find_by(id: session[:user_id])
			@user = User.create
			session[:user_id] = @user.id
		end

		return @user
	end

	def user_address
		session[:user_address]
	end
end