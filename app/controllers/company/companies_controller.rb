class Company::CompaniesController < Company::Base
	before_action :set_company, only: :show

	def show
		@products = @company.products
	end
end
