class Api::V1::Product::ProductsController < Api::V1::Product::Base
	def index
		@q = Product.active.includes(:company).ransack(params[:q])

		@user = ::User.find_by(token: params[:user_token])

		if @user && @user.coordinates
			@products = @q.result.near(@user.coordinates, 5000).paginate(page: params[:page])
		elsif params[:lat].present? && params[:lng].present?
			@products = @q.result.near([params[:lat], params[:lng]], 5000).paginate(page: params[:page])
		else
			@products = @q.result.paginate(page: params[:page])
		end
	end
end
