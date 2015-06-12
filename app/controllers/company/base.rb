class Company::Base < ApplicationController
	before_action :set_company

	protected

	def set_company
		@company = Company.friendly.find(params[:company_id] || params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:danger] = t('messages.not_found', model: Company.model_name.human)
		redirect_back and return
	end

	def check_company_authorization!
		unless current_company == @company
			flash[:danger] = t('not_authorized')
			redirect_back and return
		end
	end
end