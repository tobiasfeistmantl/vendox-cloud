class Company::PasswordResetController < Company::Base
	before_action :set_company, only: [:edit, :update]
	before_action :verify_password_reset_token!, only: [:edit, :update]

	def new
		@company = Company.new
	end

	def create
		@company = Company.find_by email: params[:company][:email]

		if @company
			if @company.generate_password_reset_token && @company.save(validate: false) && CompanyMailer.password_reset_mail(@company).deliver_now
				flash[:success] = t('messages.password_reset_link_send')
				redirect_to root_path
			else
				flash[:danger] = t('messages.generic_error')
				redirect_back
			end
		else
			redirect_to new_company_password_path
		end
	end

	def edit
	end

	def update
		if @company.update company_password_params
			@company.update_attribute(:password_reset_token, nil)

			flash[:success] = t('messages.updated', model: Company.model_name.human)
			redirect_to new_company_session_path
		else
			flash[:danger] = t('messages.unable_to_save')
			redirect_back and return
		end
	end

	protected

	def verify_password_reset_token!
		if not @company.password_reset_token.present? && ActiveSupport::SecurityUtils.secure_compare(@company.password_reset_token, params[:reset_token])
			render :edit
			return
		end
	end

	def company_password_params
		params.require(:company).permit(:password, :password_confirmation)
	end
end
