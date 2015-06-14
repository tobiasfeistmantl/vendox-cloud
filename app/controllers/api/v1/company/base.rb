class Api::V1::Company::Base < Api::V1::Base
	before_action :set_company

	protected

	def set_company
		@company = Company.includes(:products).find(params[:company_id] || params[:id])
	rescue ActiveRecord::RecordNotFound
		respond_with "Not Found", status: 404

		return
	end
end