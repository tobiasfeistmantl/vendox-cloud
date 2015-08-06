class Api::V2::Company::Base < Api::V2::Base
	before_action :set_company

	protected

	def set_company
		@company = Company.includes(:products).find(params[:company_id] || params[:id])
	rescue ActiveRecord::RecordNotFound
		render json: { errors: ["Company not found"] }, status: 404

		return
	end
end