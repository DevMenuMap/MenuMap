require 'test_helper'

class HelpQnasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

# admin일 때에만 가능.
=begin
  test "should get edit" do
    get :edit
    assert_response :success
  end
=end
end
