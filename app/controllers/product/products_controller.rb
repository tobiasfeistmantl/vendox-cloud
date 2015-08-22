class Product::ProductsController < Product::Base
	def index
		@q = Product.includes(:company).active.ransack(params[:q])

		if params[:location].present? && params[:lng].present? && params[:lat].present? && current_user_session.present?
			new_position = current_user_session.positions.create(latitude: params[:lat], longitude: params[:lng])
			session[:user_address] = params[:location]
		end

		if current_user_session && current_user_session.position.present?
			@products = @q.result.near(current_user_session.coordinates, 500).paginate(page: params[:page])
		else
			@products = @q.result.paginate(page: params[:page])
		end
	end
end
