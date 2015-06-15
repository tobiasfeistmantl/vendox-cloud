class Api::V1::Company::CompaniesController < Api::V1::Company::Base
	include Api::V1::User::SessionsHelper

	before_action :set_company, only: :show

	def index
		@user_session = find_user_session_by_token(params[:session_token])

		if @user_session && @user_session.coordinates
			@companies = Company.near(@user_session.coordinates, 5000).paginate(page: params[:page])
		else
			@companies = Company.all.paginate(page: params[:page])
		end
	end

	def show
	end
end
