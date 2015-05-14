class Product::ProductsController < Product::Base
	def index
		@q = Product.active.ransack(params[:q])

		if params[:location].present? && params[:lng].present? && params[:lat].present?
			set_current_user_location(params[:location], params[:lat], params[:lng])

			session[:auto_located] = false
		end

		if current_user_location.present?
			@products = @q.result.includes(:company, :category).near(current_user_location_coordinates, 500).paginate(page: params[:page])
		else
			@products = @q.result.includes(:company, :category).all.paginate(page: params[:page])
		end
	end
end
