module Company::SessionsHelper
	def company_signed_in?
		current_company.present?
	end

	def current_company
		if company_id = cookies.signed[:company_id]
			@company = Company.find_by(id: company_id)

			if @company.blank?
				cookies.delete(:company_id)
			else
				return @company
			end
		end
	end
end
