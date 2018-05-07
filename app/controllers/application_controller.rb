class ApplicationController < ActionController::Base

	before_action :sanitize_devise_parameters, if: :devise_controller?

	def sanitize_devise_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
	end

	def after_sign_in_path_for(_resource_or_scope)
		user_path(current_user)
	end

end
