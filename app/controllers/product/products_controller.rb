class Product::ProductsController < Product::Base
	def index
		@q = Product.includes(:company).active.ransack(params[:q])

		if current_user_session && current_user_session.position.present?
			@products = @q.result.near(current_user_session.coordinates, 500).paginate(page: params[:page])
		else
			@products = @q.result.paginate(page: params[:page])
		end
	end
end
