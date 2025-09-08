# frozen_string_literal: true

require 'application_system_test_case'

class EducatorsDashboardTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)

    @lo1 = Lo.create!(title: 'Funções de 1º grau', description: 'OA 1', user: @user)
    @lo2 = Lo.create!(title: 'Equações quadráticas', description: 'OA 2', user: @user)

    visit educators_root_path
  end

  should 'show welcome header' do
    assert_selector 'h1', text: I18n.t('educators.home.dashboard.welcome')
    assert_selector 'span', text: I18n.t('educators.home.dashboard.span')
  end

  should 'show OAs in the grid' do
    within 'div.grid' do
      assert_text @lo1.title
      assert_text @lo2.title
    end
  end

  should 'show empty message when no OAs exist' do
    Lo.destroy_all
    visit educators_root_path

    assert_selector 'div.flex', text: I18n.t('educators.los.empty.oa_not_found')
  end
end
