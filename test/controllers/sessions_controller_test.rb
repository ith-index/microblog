require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get log in" do
    get log_in_url
    assert_response :success
  end
end
