class Users::Auth::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  before_action :configure_sign_up_params, only: [:create]

  def after_inactive_sign_up_path_for(_resource)
    new_user_session_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
