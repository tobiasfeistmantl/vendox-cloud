class Company::CompaniesController < Company::Base
	before_action :set_company, only: :show

	def show
		if @company == current_company
			@products = @company.products.paginate(page: params[:page])
		else
			@products = @company.products.active.paginate(page: params[:page])
		end

		@messages = @company.messages.paginate(page: params[:page]).order(created_at: :desc)

		if current_user_location && @company != current_company
			@distance_to_company = @company.distance_to(current_user_location_coordinates)

			@message = @company.messages.new
		end
	end
end
