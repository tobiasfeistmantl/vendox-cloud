class Company::CompaniesController < Company::Base
	before_action :set_company, only: :show

	def show
		if @company == current_company
			@products = @company.products.paginate(page: params[:page])
		else
			@products = @company.products.active.paginate(page: params[:page])
		end
	end
end
