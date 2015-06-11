class Api::V1::Product::ProductsController < Product::Base
	respond_to :json

	def index
		@q = Product.active.includes(:company).ransack(params[:q])

		@user = current_user

		if params[:lat].present? && params[:lng].present?
			@products = @q.result.near([params[:lat], params[:lng]], 5000).paginate(page: params[:page])
		else
			@products = @q.result.paginate(page: params[:page])
		end
	end
end
