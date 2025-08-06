class Educators::BaseController < ApplicationController
  include Breadcrumbs
  before_action :authenticate_user!
  layout 'educators/application'

  private

    def default_breadcrumbs
      add_breadcrumb I18n.t("educators.home.breadcrumbs"), educators_root_path
    end
end
