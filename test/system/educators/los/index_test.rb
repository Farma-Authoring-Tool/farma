require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo, user: @user)
    attach_picture(@lo, 'image_base_test.jpg')

    visit educators_los_path
  end

  should 'show recently modified OA' do
    assert_text @lo.title.truncate(20)
    assert_selector "img[src*='image_base_test.jpg']"
  end

  should 'navigate to OA details page when clicking on an OA' do
    find("img[src*='image_base_test.jpg']").click

    assert_current_path educators_lo_path(@lo)
  end

  should 'edit OA by clicking edit icon' do
    find("a[href='#{edit_educators_lo_path(@lo)}']").click

    assert_current_path edit_educators_lo_path(@lo)
  end

  should 'remove OA by clicking delete icon' do
    accept_confirm do
      find("form.button_to[action='#{educators_lo_path(@lo)}'] button").click
    end

    assert_selector('[role="alert"]', text: I18n.t('educators.los.destroy.success'))
  end

  should 'show empty message when no OAs exist' do
    Lo.destroy_all
    visit educators_root_path

    assert_selector 'div.flex', text: I18n.t('educators.los.empty.oa_not_found')
  end

  should 'navigate to create OA page when clicking on create OA button' do
    within 'main' do
      find('button[data-action="click->dropdown#toggle"]').click

      find("a[href='#{new_educators_lo_path}']").click
    end

    assert_current_path new_educators_lo_path
  end
end
