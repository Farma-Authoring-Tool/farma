# frozen_string_literal: true

require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)

    visit new_user_session_path
  end

  should 'log in successfully with valid credentials' do
    within 'form' do
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password
      click_button I18n.t('devise.sessions.new.submit')
    end

    assert_current_path users_choose_profile_path
  end

  should 'fail to log in with incorrect password' do
    within 'form' do
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: 'wrongpassword'
      click_button I18n.t('devise.sessions.new.submit')
    end

    assert_selector('[role="alert"]', text: I18n.t('devise.failure.invalid'))
  end

  should 'stay on login page when fields are blank' do
    within 'form' do
      click_button I18n.t('devise.sessions.new.submit')
    end

    assert_current_path new_user_session_path
  end

  should 'navigate to password recovery page via forgot password link' do
    click_link I18n.t('devise.sessions.new.forgot_password')

    assert_current_path new_user_password_path
  end
end
