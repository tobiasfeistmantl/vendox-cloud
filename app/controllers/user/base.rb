class User::Base < ApplicationController
	before_action :set_user

	protected

	def set_user
		@user = User.find_by(token: params[:token] || params[:user_token])

		unless @user
			flash[:danger] = t('messages.not_found', model: User.model_name.human)
			redirect_back and return
		end
	end
end