require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { admin: @user.admin, birthday: @user.birthday, city: @user.city, email: @user.email, emergency_email: @user.emergency_email, emergency_first: @user.emergency_first, emergency_last: @user.emergency_last, emergency_notes: @user.emergency_notes, emergency_phone: @user.emergency_phone, emergency_relationship: @user.emergency_relationship, first: @user.first, gender: @user.gender, guide_status: @user.guide_status, last: @user.last, phone: @user.phone, state: @user.state, street_address: @user.street_address }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { admin: @user.admin, birthday: @user.birthday, city: @user.city, email: @user.email, emergency_email: @user.emergency_email, emergency_first: @user.emergency_first, emergency_last: @user.emergency_last, emergency_notes: @user.emergency_notes, emergency_phone: @user.emergency_phone, emergency_relationship: @user.emergency_relationship, first: @user.first, gender: @user.gender, guide_status: @user.guide_status, last: @user.last, phone: @user.phone, state: @user.state, street_address: @user.street_address }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
