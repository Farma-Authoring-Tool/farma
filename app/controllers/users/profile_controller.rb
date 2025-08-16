class Users::ProfileController < ApplicationController
  def choose
    render 'users/profile/choose', layout: 'users/application'
  end
end
