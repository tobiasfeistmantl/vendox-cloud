class CompanyMailer < ApplicationMailer
	def confirmation_mail(company)
		@company = company

		mail to: @company.email, subject: t('mailer.subjects.confirmation_mail')
	end
end
