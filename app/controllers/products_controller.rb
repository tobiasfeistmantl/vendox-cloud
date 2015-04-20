class ProductsController < ApplicationController
	def index
		@q = Product.ransack(params[:q])

		@user_location = params[:location]

		if @user_location.present?
			@products = @q.result.includes(:company).near(@user_location).paginate(page: params[:page])
		else
			@products = @q.result.includes(:company).all.paginate(page: params[:page])
		end
	end
end
