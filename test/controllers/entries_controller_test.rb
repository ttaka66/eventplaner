require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  test "should get update" do
    get :update
    assert_response :success
  end

end
