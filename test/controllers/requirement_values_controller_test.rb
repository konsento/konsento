require 'test_helper'

class RequirementValuesControllerTest < ActionController::TestCase
  setup do
    @requirement_value = requirement_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requirement_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requirement_value" do
    assert_difference('RequirementValue.count') do
      post :create, requirement_value: {  }
    end

    assert_redirected_to requirement_value_path(assigns(:requirement_value))
  end

  test "should show requirement_value" do
    get :show, id: @requirement_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requirement_value
    assert_response :success
  end

  test "should update requirement_value" do
    patch :update, id: @requirement_value, requirement_value: {  }
    assert_redirected_to requirement_value_path(assigns(:requirement_value))
  end

  test "should destroy requirement_value" do
    assert_difference('RequirementValue.count', -1) do
      delete :destroy, id: @requirement_value
    end

    assert_redirected_to requirement_values_path
  end
end
