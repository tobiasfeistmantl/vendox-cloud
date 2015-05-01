class AccountMailer < Devise::Mailer
	helper :application

	def confirmation_instructions(record, token, opts={})
		@record = 
	end
end