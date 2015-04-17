class Company::Api::CompaniesController < Company::Base
	before_action :set_company, only: :show

	def index
		@companies = Company.all

		render json: @companies
	end

	def show
		render json: @company
	end
end
