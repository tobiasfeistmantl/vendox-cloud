class FeedbacksController < ApplicationController
	def new
	end

	def create
		FeedbackMailer.send_feedback(params[:feedback][:email], params[:feedback][:subject], params[:feedback][:description], current_user_location, request.remote_ip).deliver_now

		flash[:success] = t('messages.thank_you_for_your_feedback')
		redirect_back
	end
end
