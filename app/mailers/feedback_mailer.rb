class FeedbackMailer < ApplicationMailer
	default from: 'feedbacks@vendox.net'

	def send_feedback(user_email, subject, description, location = nil, remote_ip)
		@user_email = user_email
		@description = description
		@location = location
		@remote_ip = remote_ip

		mail(to: ENV['FEEDBACK_RECEIVER_EMAIL'], subject: subject)
	end
end
