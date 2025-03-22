require 'test_helper'

class Api::Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
  end

  test 'should log in user and return JWT token' do
    post api_user_session_path, params: { user: { email: @user.email, password: @user.password } }, as: :json

    assert_response :success
    jwt = response.headers['Authorization'].last || json_response['jwt']

    assert_not_nil jwt
  end

  test 'should not log in user with invalid credentials' do
    post api_user_session_path, params: { user: { email: @user.email, password: 'wrongpassword' } }, as: :json

    assert_response :unauthorized
  end

  # test 'should log out user' do
  #   post api_user_session_path, params: { user: { email: @user.email, password: @user.password } }, as: :json
  #   token = response.headers['Authorization']
  #   assert_not_nil token, 'Expected Authorization header to be present'
  #
  #   # headers = { 'Authorization' => response.headers['Authorization'] }
  #   headers = {Authorization: response.headers['Authorization']}
  #   p headers
  #   delete api_destroy_user_session_path, headers: headers, as: :json
  #
  #   assert_response :success
  # end

  private

  def json_response
    response.parsed_body
  end
end
