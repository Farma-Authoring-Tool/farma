class Students::HomeController < ApplicationController
  before_action :authenticate_user!

  layout 'user/application'
  def index; end
end
