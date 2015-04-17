class WelcomeController < ApplicationController
	def index
		@q = Product.ransack
		@products = @q.result.paginate(page: params[:page])
	end
end
