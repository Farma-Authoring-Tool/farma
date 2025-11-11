require 'application_system_test_case'

class ShowTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo, user: @user)
    attach_picture(@lo, 'image_base_test.jpg')

    visit educators_lo_path(@lo)
  end

  should 'show title and description OA' do
    assert_text @lo.title.truncate(50)
    assert_text @lo.description.truncate(300)
    assert_selector "img[src*='image_base_test.jpg']"
  end

  should 'navigate to create Exercise page when clicking on create Exercise button' do
    within 'main' do
      find('button[data-action="click->dropdown#toggle"]').click

      find("a[href='#{new_educators_lo_exercise_path(@lo)}']").click
    end

    assert_current_path new_educators_lo_exercise_path(@lo)
  end

  should 'navigate to create Introduction page when clicking on create Introduction button' do
    within 'main' do
      find('button[data-action="click->dropdown#toggle"]').click

      find("a[href='#{new_educators_lo_introduction_path(@lo)}']").click
    end

    assert_current_path new_educators_lo_introduction_path(@lo)
  end
end
