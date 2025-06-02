module Educator
  class HomeController < ApplicationController
    before_action :authenticate_user!

    layout 'user/application'
    def index
      # Logica
    end
  end
end
