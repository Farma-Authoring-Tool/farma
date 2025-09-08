# frozen_string_literal: true

require 'application_system_test_case'

class ChooseProfileTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)
    visit users_choose_profile_path
  end

  should 'display text' do
    assert_text I18n.t('users.profile.choose.select')
    assert_text I18n.t('users.profile.choose.student.desc')
    assert_text I18n.t('users.profile.choose.educator.desc')
  end

  should 'display profile navigation links and home page link' do
    assert_link text: I18n.t('users.profile.choose.student.title'), href: students_root_path
    assert_link text: I18n.t('users.profile.choose.educator.title'), href: educators_root_path
    assert_link href: root_path
  end

  should 'navigate to student profile' do
    click_on I18n.t('users.profile.choose.student.title')

    assert_text I18n.t('users.profile.student')
    assert_current_path students_root_path
  end

  should 'navigate to educator profile' do
    click_on I18n.t('users.profile.choose.educator.title')

    assert_text I18n.t('educators.home.dashboard.welcome')
    assert_current_path educators_root_path
  end
end
