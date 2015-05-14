class Api::V1::Company::ProductsController < Company::Base
	before_action :set_product, only: :show

	def index
		@products = @company.products

		render json: @products
	end

	def show
		render json: @product
	end

	private

	def set_product
		@product = @company.products.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		render nothing: true

		return
	end
end
