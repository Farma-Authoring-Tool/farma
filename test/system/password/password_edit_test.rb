# frozen_string_literal: true

require 'application_system_test_case'

class PasswordEditTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)

    visit edit_user_password_path(reset_password_token: @user.send(:set_reset_password_token))
  end

  should 'user can change password' do
    within 'form' do
      fill_in :user_password, with: 'newpassword'
      fill_in :user_password_confirmation, with: 'newpassword'
      click_button I18n.t('devise.passwords.edit.submit')
    end

    assert_current_path users_choose_profile_path
  end

  should 'blank email' do
    within 'form' do
      click_button I18n.t('devise.passwords.edit.submit')
    end

    assert_selector 'div.user_password p', text: I18n.t('errors.messages.blank')
  end
end
