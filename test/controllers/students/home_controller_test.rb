require 'test_helper'

class Students::HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    sign_in @user
  end

  test 'should get index' do
    get students_url

    assert_response :success
  end
end
