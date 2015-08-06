class Api::V2::Company::CompaniesController < Api::V2::Company::Base
	before_action :set_company, only: :show

	def index
		if coordinates = @user_session.coordinates
			@companies = Company.near(coordinates, 5000).paginate(page: params[:page])
		else
			@companies = Company.all.paginate(page: params[:page])
		end
	end

	def show
	end
end
