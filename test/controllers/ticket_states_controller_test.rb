require 'test_helper'

class TicketStatesControllerTest < ActionController::TestCase
  setup do
    @ticket_state = ticket_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticket_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket_state" do
    assert_difference('TicketState.count') do
      post :create, ticket_state: { name: @ticket_state.name }
    end

    assert_redirected_to ticket_state_path(assigns(:ticket_state))
  end

  test "should show ticket_state" do
    get :show, id: @ticket_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket_state
    assert_response :success
  end

  test "should update ticket_state" do
    patch :update, id: @ticket_state, ticket_state: { name: @ticket_state.name }
    assert_redirected_to ticket_state_path(assigns(:ticket_state))
  end

  test "should destroy ticket_state" do
    assert_difference('TicketState.count', -1) do
      delete :destroy, id: @ticket_state
    end

    assert_redirected_to ticket_states_path
  end
end
