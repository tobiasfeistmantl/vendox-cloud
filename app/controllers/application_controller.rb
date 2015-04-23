class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	include ApplicationHelper
	include LocationsHelper
	
	def set_user_position
		latitude = params[:lat]
		longitude = params[:lng]

		address = Geocoder.address([latitude, longitude])

		session[:user_location] = address

		render html: "#{t('your_current_location_is')} <strong>#{current_user_location}</strong>".html_safe
	end
end
