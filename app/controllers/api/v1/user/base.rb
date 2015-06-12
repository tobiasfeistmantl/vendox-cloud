class Api::V1::User::Base < User::Base
	respond_to :json

	protected

	def set_user
		@user = User.find_by(token: params[:token] || params[:user_token])

		unless @user
			respond_with "Not Found", status: 404
			
			return
		end
	end
end