class Company::CompaniesController < Company::Base
	before_action :set_company, only: [:show, :confirm]

	def new
		@company = Company.new
	end

	def create
		@company = Company.new company_params

		unless verify_recaptcha
			flash.now[:danger] = t('messages.validation_of_recatcha_failed')
			flash.delete :recaptcha_error
			render :new
			return
		end

		@company.generate_confirmation_token

		if @company.save
			CompanyMailer.confirmation_mail(@company).deliver_now

			flash[:success] = t('messages.sign_up_successful')
			redirect_to root_path
		else
			puts(@company.errors.messages)
			flash.now[:danger] = t('messages.unable_to_save')
			render :new
		end
	end

	def show
		if @company == current_company
			@products = @company.products.paginate(page: params[:page])
		else
			@products = @company.products.active.paginate(page: params[:page])
		end
	end

	## Non-RESTful method to confirm company accounts
	def confirm
		if @company.confirmation_token.present?
			if ActiveSupport::SecurityUtils.secure_compare(params[:confirmation_token], @company.confirmation_token)
				if @company.confirm
					flash[:success] = t('messages.account_confirmed')
				end

				redirect_to new_company_session_path
			else
				flash[:danger] = t('messages.invalid_confirmation_token')
				redirect_to root_path
			end
		else
			flash[:info] = t('messages.account_already_confirmed')
			redirect_to new_company_session_path
		end
	end

	protected

	def company_params
		params.require(:company).permit(:name, :email, :password, :password_confirmation, :street, :zip_code, :locality, :phone_number, :vat_number)
	end
end
