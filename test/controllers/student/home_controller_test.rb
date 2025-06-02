require 'test_helper'

class Student::HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    sign_in @user
  end

  test 'should get index' do
    get student_url

    assert_response :success
  end
end
