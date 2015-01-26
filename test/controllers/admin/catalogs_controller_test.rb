require 'test_helper'

class Admin::CatalogsControllerTest < ActionController::TestCase
  setup do
    @admin_catalog = admin_catalogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_catalogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_catalog" do
    assert_difference('Admin::Catalog.count') do
      post :create, admin_catalog: { name: @admin_catalog.name }
    end

    assert_redirected_to admin_catalog_path(assigns(:admin_catalog))
  end

  test "should show admin_catalog" do
    get :show, id: @admin_catalog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_catalog
    assert_response :success
  end

  test "should update admin_catalog" do
    patch :update, id: @admin_catalog, admin_catalog: { name: @admin_catalog.name }
    assert_redirected_to admin_catalog_path(assigns(:admin_catalog))
  end

  test "should destroy admin_catalog" do
    assert_difference('Admin::Catalog.count', -1) do
      delete :destroy, id: @admin_catalog
    end

    assert_redirected_to admin_catalogs_path
  end
end
