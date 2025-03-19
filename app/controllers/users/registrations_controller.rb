# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  respond_to :json

  # protected
  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: { message: I18n.t('devise.registrations.signed_up'), user: current_user.as_json },
             status: :created
    else
      render json: {
        message: I18n.t('messages.actions.errors'), user: current_user.as_json, errors: current_user.errors
      }, status: :unprocessable_entity
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
