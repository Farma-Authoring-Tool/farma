require 'test_helper'

class Educator::HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user) # Sem trait
    sign_in @user
  end

  test 'should get index' do
    get educator_url

    assert_response :success
  end
end
