class Api::V1::Product::ProductsController < Product::Base
	respond_to :json

	def index
		if params[:lat] && params[:lng]
			@products = Product.active.includes(:company, :category).near([params[:lat], params[:lng]], 20)
		else
			@products = Product.active.includes(:company, :category).all.paginate(page: params[:page])
		end
	end
end
