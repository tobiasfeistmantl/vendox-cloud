module ApplicationHelper
	def flash_class(level)
		case level.to_sym
			# Default types
			when :success then "success"
			when :info then "info"
			when :warning then "warning"
			when :danger then "danger"
			
			when :notice then "info"
			when :alert then "danger"
		end
	end

	def redirect_back
		redirect_to :back
	rescue ActionController::RedirectBackError
		redirect_to root_path
	end

end
