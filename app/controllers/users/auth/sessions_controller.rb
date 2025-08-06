class Users::Auth::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:new, :create]

  layout 'devise/application'

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || users_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
