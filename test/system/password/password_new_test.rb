# frozen_string_literal: true

require 'application_system_test_case'

class PasswordNewTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user)

    visit new_user_password_path
  end

  should 'sending password change email' do
    within 'form' do
      fill_in :user_email, with: @user.email
      click_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
    end

    assert_current_path new_user_session_path
    assert_text I18n.t('devise.passwords.send_instructions')
  end

  # should 'blank email' do
  # within 'form' do
  # click_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
  # end

  # assert_text 'não pode ficar em branco'
  # end
end
