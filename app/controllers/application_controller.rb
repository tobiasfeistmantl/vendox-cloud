class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	include ApplicationHelper
	include LocationsHelper
	
	before_action :set_locale

	def set_user_position
		longitude = params[:lng]
		latitude = params[:lat]
		address = params[:addr]

		session[:user_location] = address
		session[:user_lng] = longitude
		session[:user_lat] = latitude
		session[:last_location_update] = Time.now

		render text: "#{t('your_current_location_is')} <strong>#{current_user_location}</strong>".html_safe
	end

	def set_locale
		I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options = {})
		{ locale: I18n.locale }.merge options
	end
end
