class ProductsController < ApplicationController
	def index
		@q = Product.ransack(params[:q])
		@products = @q.result
	end
end
