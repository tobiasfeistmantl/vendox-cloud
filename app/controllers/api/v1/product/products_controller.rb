class Api::V1::Product::ProductsController < Product::Base
	respond_to :json

	def index
		if params[:lat] && params[:lng]
			@products = Product.near([params[:lat], params[:lng]], 20)
		else
			@products = Product.all.paginate(page: params[:page])
		end

		respond_with @products
	end
end
