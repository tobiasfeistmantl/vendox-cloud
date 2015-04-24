class ProductsController < ApplicationController
	def index
		@q = Product.active.ransack(params[:q])

		if params[:location].present?
			session[:user_location] = params[:location]
		end

		if current_user_location.present?
			@products = @q.result.includes(:company).near(current_user_location_coordinates).paginate(page: params[:page]).includes(:category)
		else
			@products = @q.result.includes(:company).all.paginate(page: params[:page]).includes(:category)
		end
	end
end
