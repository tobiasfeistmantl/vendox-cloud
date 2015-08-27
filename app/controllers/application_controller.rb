class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	include ApplicationHelper
	include LocationsHelper
	include Api::V1::User::SessionsHelper
	include Company::SessionsHelper

	before_action :set_locale
	before_action :set_gon_variables

	def set_locale
		I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options = {})
		{ locale: I18n.locale }.merge options
	end

	def set_gon_variables
		gon.user_address = session[:user_address]
		gon.session_token = session[:session_token]
		gon.api_v2_user_sessions_path = api_v2_user_sessions_path(locale: nil)
		gon.api_v1_user_positions_path = api_v1_user_positions_path(locale: nil)

		gon.i18n_search_for_something = t('search_for_something')
	end
end
