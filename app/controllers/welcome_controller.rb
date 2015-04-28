class WelcomeController < ApplicationController
	def index
		@q = Product.ransack(params[:q])

		@companies = Company.all

		@maps_hash = hash_for_maps(@companies)
	end

	def imprint
	end
end
