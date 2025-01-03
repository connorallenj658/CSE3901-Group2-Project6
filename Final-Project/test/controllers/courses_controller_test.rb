require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get courses_show_url
    assert_response :success
  end

  test "should get index" do
    get courses_index_url
    assert_response :success
  end

  test "should get create" do
    get courses_create_url
    assert_response :success
  end

  test "should get destroy" do
    get courses_destroy_url
    assert_response :success
  end

  test "should get update" do
    get courses_update_url
    assert_response :success
  end
end
