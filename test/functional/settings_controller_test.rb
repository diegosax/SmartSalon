require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  setup do
    @setting = settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create setting" do
    assert_difference('Setting.count') do
      post :create, setting: { client_can_schedule: @setting.client_can_schedule, closing_time: @setting.closing_time, opening_time: @setting.opening_time, searchable: @setting.searchable, work_on_saturdays: @setting.work_on_saturdays, work_on_sundays: @setting.work_on_sundays }
    end

    assert_redirected_to setting_path(assigns(:setting))
  end

  test "should show setting" do
    get :show, id: @setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @setting
    assert_response :success
  end

  test "should update setting" do
    put :update, id: @setting, setting: { client_can_schedule: @setting.client_can_schedule, closing_time: @setting.closing_time, opening_time: @setting.opening_time, searchable: @setting.searchable, work_on_saturdays: @setting.work_on_saturdays, work_on_sundays: @setting.work_on_sundays }
    assert_redirected_to setting_path(assigns(:setting))
  end

  test "should destroy setting" do
    assert_difference('Setting.count', -1) do
      delete :destroy, id: @setting
    end

    assert_redirected_to settings_path
  end
end
