class Educators::HomeController < ApplicationController
  before_action :authenticate_user!

  layout 'educators/application'

  def dashboard; end
end
