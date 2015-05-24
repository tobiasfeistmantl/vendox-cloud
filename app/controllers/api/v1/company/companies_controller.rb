class Api::V1::Company::CompaniesController < Company::Base
	respond_to :json

	before_action :set_company, only: :show

	def index
		if params[:lat] && params[:lng]
			@companies = Company.near([params[:lat], params[:lng]], 20).paginate(page: params[:page])
		else
			@companies = Company.all.paginate(page: params[:page])
		end

		respond_with @companies
	end

	def show
		respond_with @company
	end

	private

	def set_company
		@company = Company.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		respond_with "Not Found", status: 404

		return
	end
end
