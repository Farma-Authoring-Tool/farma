# frozen_string_literal: true

require 'application_system_test_case'

class RecentLosTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)

    @lo = create(:lo, user: @user)
    attach_picture(@lo, 'image_base_test.jpg')

    sign_in @user
    visit educators_root_path
  end

  should 'show recently modified OA' do
    assert_text @lo.title.truncate(20)
    assert_selector "img[src*='image_base_test.jpg']"
  end

  should 'navigate to OA edit' do
    find("a[href='#{edit_educators_lo_path(@lo)}']").click

    assert_current_path edit_educators_lo_path(@lo)
  end

  should 'show empty message when no OAs exist' do
    Lo.destroy_all
    visit educators_root_path

    assert_selector 'div.flex', text: I18n.t('educators.los.index.empty')
  end
end
