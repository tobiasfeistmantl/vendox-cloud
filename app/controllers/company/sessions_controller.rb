class Company::SessionsController < ApplicationController
	def new
		@company = Company.new
	end

	def create
		@company = Company.find_by(email: params[:company][:email])

		if @company && @company.authenticate(params[:company][:password])
			if @company.confirmed?
				if params[:remember_me] == "true"
					cookies.permanent.signed[:company_id] = @company.id
				else
					cookies.signed[:company_id] = @company.id
				end

				flash[:success] = t('messages.signed_in')
				redirect_to root_path
			else
				flash[:danger] = t('messages.account_not_confirmed')
				redirect_back
			end
		else
			flash[:danger] = t('messages.invalid_credentials')
			redirect_back
		end
	end

	def destroy
		cookies.delete(:company_id)
		
		if not company_signed_in?
			flash[:success] = t('messages.logged_out')
			redirect_to root_path
		else
			flash[:danger] = t('messages.still_logged_in')
			redirect_to root_path
		end
	end
end
