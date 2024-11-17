defmodule ExpenseTrackerWeb.LoginLiveTest do
  use ExpenseTrackerWeb.ConnCase, async: false
  import Phoenix.LiveViewTest

  setup do
    ExpenseTracker.Store.start_link([])
    :ok
  end

  test "successful login redirects to expense tracker with query param", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    username = "test_user"
    assert render_change(view, :validate_username, %{"username" => username}) =~ "Login"

    render_submit(view, :login, %{"username" => username})
    assert_redirect(view, "/expenses?username=#{username}")
  end

  test "shows error if username is taken", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    ExpenseTracker.Store.add_username("existing_user")

    assert render_change(view, :validate_username, %{"username" => "existing_user"}) =~
             "Username already taken"
  end
end
