class Users::Auth::PasswordsController < Devise::PasswordsController
  layout 'devise/application'

  def after_resetting_password_path_for(_resource)
    users_choose_profile_path
  end
end
