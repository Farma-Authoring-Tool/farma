class Api::BaseController < ActionController::API
  include ActionController::MimeResponds
  include ActionsMessages

  respond_to :json
end
