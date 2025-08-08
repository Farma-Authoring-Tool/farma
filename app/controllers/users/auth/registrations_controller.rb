class Users::Auth::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  layout 'devise/application'

  def after_inactive_sign_up_path_for(_resource)
    new_user_session_path
  end

  def after_sign_up_path_for(_resource)
    users_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

    def require_no_authentication
      return unless user_signed_in?

      redirect_to users_choose_profile_path, alert: I18n.t('devise.failure.already_authenticated')
    end
end
