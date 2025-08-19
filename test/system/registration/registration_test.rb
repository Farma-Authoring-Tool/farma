# frozen_string_literal: true

require 'application_system_test_case'

class RegistrationTest < ApplicationSystemTestCase
  setup do
    @user = build(:user)
    visit new_user_registration_path
  end

  should 'user can register' do
    within 'form' do
      fill_in :user_name, with: @user.name
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password
      fill_in :user_password_confirmation, with: @user.password
      click_button I18n.t('devise.registrations.new.submit')
    end

    assert_current_path users_choose_profile_path
  end

  should 'email already registered' do
    existing_user = create(:user, email: @user.email)

    visit new_user_registration_path

    within 'form' do
      fill_in :user_name, with: 'teste'
      fill_in :user_email, with: existing_user.email
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      click_button I18n.t('devise.registrations.new.submit')
    end

    assert_current_path new_user_registration_path
    assert_text I18n.t('errors.messages.taken')
  end

  should 'sending blank form' do
    click_button I18n.t('devise.registrations.new.submit')

    assert_selector 'div.user_name p', text: I18n.t('errors.messages.blank')
    assert_selector 'div.user_email p', text: I18n.t('errors.messages.blank')
    assert_selector 'div.user_password p', text: I18n.t('errors.messages.blank')
  end
end
