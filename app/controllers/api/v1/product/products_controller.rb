class Api::V1::Product::ProductsController < Api::V1::Product::Base
	include Api::V1::User::SessionsHelper

	def index
		@q = ::Product.active.includes(:company).ransack(params[:q])

		@user_session = find_user_session_by_token(params[:session_token])

		if params[:without_position] != "1" && @user_session && @user_session.coordinates
			@products = @q.result.near(@user_session.coordinates, 5000).paginate(page: params[:page])
		else
			@products = @q.result.paginate(page: params[:page])
		end
	end
end
