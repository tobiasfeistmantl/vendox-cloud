class Api::V1::User::Base < Api::V1::Base
	before_action :set_user

	protected

	def set_user
		@user = User.find_by(token: params[:token] || params[:user_token])

		unless @user
			respond_with "Not Found", status: 404
			
			return
		end
	end
end