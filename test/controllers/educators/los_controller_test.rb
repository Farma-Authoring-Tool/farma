require 'support/asset_helpers'
require 'test_helper'

class Educators::LosControllerTest < ActionDispatch::IntegrationTest
  include TestAssetHelpers

  def setup
    @user = create(:user)
    sign_in @user

    @lo = FactoryBot.create(:lo, user: @user)

    attach_picture(@lo, 'test/fixtures/files/image_base_test.jpg')
  end

  test 'should get /educators/los' do
    get educators_los_path

    assert_response :success
  end

  test 'should show educators/los' do
    get educators_lo_path(@lo)

    assert_response :success
  end

  test 'should create /los/new' do
    assert_difference('Lo.count', 1) do
      post educators_los_path, params: { lo: { title: 'Novo OA', description: 'Descrição OA' } }
    end

    assert_redirected_to educators_root_path

    assert_equal I18n.t('educators.los.create.success'), flash[:success]
  end

  test 'should update /los/edit' do
    patch educators_lo_path(@lo), params: { lo: { title: 'Atualizado' } }

    assert_redirected_to educators_root_path

    assert_equal I18n.t('educators.los.update.success'), flash[:success]
  end

  test 'should destroy lo' do
    assert_difference('Lo.count', -1) do
      delete educators_lo_path(@lo)
    end

    assert_redirected_to educators_los_path
  end
end
