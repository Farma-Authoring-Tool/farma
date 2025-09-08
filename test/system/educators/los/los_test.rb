# frozen_string_literal: true

require 'application_system_test_case'

class EducatorsLosIndexTest < ApplicationSystemTestCase
  setup do
    @educator = create(:user)
    sign_in(@educator)
  end

  should 'display existing OAs in a grid' do
    create(:lo, title: 'OA 1', user: @educator)
    create(:lo, title: 'OA 2', user: @educator)

    visit educators_los_path

    assert_text 'OA 1'
    assert_text 'OA 2'

    assert_selector 'div.grid'
  end

  should 'display empty message when no OAs' do
    visit educators_los_path

    assert_text I18n.t('educators.los.empty.oa_not_found')
  end

  should 'have a button to create a new OA' do
    visit educators_los_path

    find("a[href='#{new_educators_lo_path}']").click

    assert_current_path new_educators_lo_path
  end
end
