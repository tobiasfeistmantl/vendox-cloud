class WelcomeController < ApplicationController
	def index
		@q = Product.ransack(params[:q])
	end

	def imprint
	end

	def about
	end
end
