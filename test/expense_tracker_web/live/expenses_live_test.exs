defmodule ExpenseTrackerWeb.ExpenseLiveTest do
  use ExpenseTrackerWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  setup do
    start_supervised!(ExpenseTracker.Store)
    ExpenseTracker.Store.start_link([])
    :ok
  end

  test "renders expense tracker page", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/expenses?username=test_user")
    assert html =~ "Your Expenses"
  end

  test "adds a new expense", %{conn: conn} do
    ExpenseTracker.Store.start_link([])
    {:ok, view, _html} = live(conn, "/expenses?username=test_user")

    render_submit(view, :add_expense, %{
      "expense" => %{"amount" => "100", "date" => "2024-11-17", "description" => "Groceries"}
    })

    assert render(view) =~ "100"
    assert render(view) =~ "Groceries"
  end
end
