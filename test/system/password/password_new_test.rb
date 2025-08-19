# frozen_string_literal: true

require 'application_system_test_case'

class PasswordNewTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)

    visit new_user_password_path
  end

  should 'send password reset instructions to valid email' do
    within 'form' do
      fill_in :user_email, with: @user.email
      click_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
    end

    assert_current_path new_user_session_path
    assert_text I18n.t('devise.passwords.send_instructions')
  end

  should 'show error when email is blank' do
    within 'form' do
      click_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
    end

    assert_selector 'div.user_email p', text: I18n.t('errors.messages.blank')
  end
end
