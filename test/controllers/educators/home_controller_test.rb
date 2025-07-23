require 'test_helper'

class Educators::HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user) # Sem trait
    sign_in @user
  end

  test 'should get index' do
    get educators_url

    assert_response :success
  end
end
