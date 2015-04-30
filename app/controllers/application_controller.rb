class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	include ApplicationHelper
	include LocationsHelper

	before_action :set_locale
	before_action :configure_permitted_parameters, if: :devise_controller?

	def set_user_position
		set_current_user_location(params[:addr], params[:lat], params[:lng])

		if params[:a] == "true"
			session[:auto_located] = true
		end
		
		render text: "#{t('your_current_location_is')} #{current_user_location}"
	end

	def set_locale
		I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options = {})
		{ locale: I18n.locale }.merge options
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :phone_number, :vat_number, :street, :zip_code, :locality) }
	end
end
