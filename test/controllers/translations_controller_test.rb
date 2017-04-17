require 'test_helper'

class TranslationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get translations_index_url
    assert_response :success
  end

  test "should get show" do
    get translations_show_url
    assert_response :success
  end

  test "should get new" do
    get translations_new_url
    assert_response :success
  end

  test "should get create" do
    get translations_create_url
    assert_response :success
  end

end
