class Api::V1::Company::CompaniesController < Api::V1::Company::Base
	before_action :set_company, only: :show

	def index
		@user = ::User.find_by(token: params[:user_token])

		if @user && @user.coordinates
			@companies = Company.near(@user.coordinates, 5000).paginate(page: params[:page])
		elsif params[:lat] && params[:lng]
			@companies = Company.near([params[:lat], params[:lng]], 5000).paginate(page: params[:page])
		else
			@companies = Company.all.paginate(page: params[:page])
		end
	end

	def show
	end
end
