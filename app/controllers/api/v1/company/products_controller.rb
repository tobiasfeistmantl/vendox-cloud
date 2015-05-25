class Api::V1::Company::ProductsController < Company::Base
	respond_to :json

	before_action :set_product, only: :show

	def index
		@products = @company.products.active.includes(:category)
	end

	def show
	end

	private

	def set_product
		@product = @company.products.active.includes(:category).find(params[:id])
	rescue ActiveRecord::RecordNotFound
		respond_with "Not Found", status: 404

		return
	end
end
