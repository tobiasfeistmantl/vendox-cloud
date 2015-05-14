class Api::V1::Product::ProductsController < Product::Base
	def index
		@q = Product.active.ransack(params[:q])

		if current_user_location_coordinates
			@products = @q.result.includes(:company, :category).near(current_user_location_coordinates, 500).paginate(page: params[:page])
		else
			@products = @q.result.includes(:company, :category).all.paginate(page: params[:page])
		end

		render json: @products
	end
end
