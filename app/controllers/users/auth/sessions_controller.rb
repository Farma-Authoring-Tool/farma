class Users::Auth::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:new, :create]

  def after_sign_in_path_for(_resource)
    users_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
