class Api::Base < ActionController::Base
	include ActionController::HttpAuthentication::Token
	
	protect_from_forgery with: :null_session

	before_action :set_locale

	def set_locale
		I18n.locale = :en
	end
end