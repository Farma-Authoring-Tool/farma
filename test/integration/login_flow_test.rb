require 'test_helper'

class Users::LoginFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
  end

  test 'should display client login page' do
    get new_user_session_path

    assert_response :success
    assert_select 'h1', text: I18n.t('devise.sessions.new.sign_in')
  end

  test 'should login user with valid credentials' do
    post user_session_path, params: { user: { email: @user.email, password: '123456' } }

    assert_redirected_to users_path

    follow_redirect!

    assert_response :success
    assert_select 'p', 'Aluno'
  end

  test 'should not login user with invalid credentials' do
    get new_user_session_path

    assert_response :success

    post user_session_path, params: { user: { email: @user.email, password: 'wrong_password' } }

    assert_response :unprocessable_entity

    assert_select 'div.bg-red-50.text-red-800', I18n.t('devise.failure.invalid', authentication_keys: 'E-mail')
  end

  test 'should not login client with empty credentials' do
    get new_user_session_path

    assert_response :success

    post user_session_path, params: { user: { email: '', password: '' } }

    assert_response :unprocessable_entity

    assert_select 'div.bg-red-50.text-red-800', text: I18n.t('devise.failure.invalid', authentication_keys: 'E-mail')
  end
end
