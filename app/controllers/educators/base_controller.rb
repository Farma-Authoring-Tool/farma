class Educators::BaseController < ApplicationController
  include Breadcrumbs

  before_action :authenticate_user!
  layout 'educators/application'

  private

    def default_breadcrumbs
      add_breadcrumb I18n.t('educators.home.breadcrumbs'), educators_root_path
    end

    def set_breadcrumbs
      case action_name.to_sym
      when :new
        add_breadcrumb I18n.t('breadcrumbs.new_lo'), new_educators_lo_path
      when :show
        add_breadcrumb I18n.t('breadcrumbs.show_lo'), educators_lo_path
      when :edit
        add_breadcrumb I18n.t('breadcrumbs.edit_lo'), edit_educators_lo_path
      end
    end
end
