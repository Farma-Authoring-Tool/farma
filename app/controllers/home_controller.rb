class HomeController < ApplicationController
  def index
    flash.now[:success] = I18n.t('messages.actions.create.m', entity: 'User')
  end

  def test; end
end
