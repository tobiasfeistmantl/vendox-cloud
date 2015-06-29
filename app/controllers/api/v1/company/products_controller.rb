class Api::V1::Company::ProductsController < Api::V1::Company::Base
	before_action :set_product, only: :show

	def index
		@products = @company.products.active
	end

	def show
	end

	private

	def set_product
		@product = @company.products.active.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		render json: { errors: ["Product not Found"] }, status: 404

		return
	end
end
