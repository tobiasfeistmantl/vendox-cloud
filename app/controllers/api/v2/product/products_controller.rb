class Api::V2::Product::ProductsController < Api::V2::Product::Base
	def index
		@q = ::Product.active.includes(:company).ransack(params[:q])

		if coordinates = @user_session.coordinates
			@products = @q.result.near(coordinates, 5000).paginate(page: params[:page])
		else
			@products = @q.result.paginate(page: params[:page])
		end
	end
end
