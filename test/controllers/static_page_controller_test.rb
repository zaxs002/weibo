require 'test_helper'

class StaticPageControllerTest < ActionController::TestCase
  test "should get contact" do
    get :contact
    assert_response :success
  end

end
