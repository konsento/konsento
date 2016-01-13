require 'test_helper'

class Js::ProposalsControllerTest < ActionController::TestCase
  test "should get yes" do
    get :yes
    assert_response :success
  end

end
