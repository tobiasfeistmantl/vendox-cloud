class Api::V1::Company::ProductsController < Company::Base
	respond_to :json

	before_action :set_product, only: :show

	def index
		@products = @company.products

		respond_with @products
	end

	def show
		respond_with @product
	end

	private

	def set_product
		@product = @company.products.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		respond_with "Not Found", status: 404

		return
	end
end
