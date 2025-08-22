class Students::HomeController < ApplicationController
  before_action :authenticate_user!

  layout 'students/application'

  def dashboard; end
end
