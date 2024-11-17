defmodule ExpenseTracker.StoreTest do
  use ExUnit.Case
  alias ExpenseTracker.Store


  setup do
    Store.start_link([])
    :ok
  end

  test "unique_username?/1 returns true for a new username" do
    assert Store.unique_username?("user1") == true
  end

  test "add_username/1 adds a new username" do
    Store.add_username("user1")
    refute Store.unique_username?("user1")
  end

  test "add_expense/2 adds an expense for a user" do
    Store.add_username("user1")
    expense = %{amount: 100, date: ~D[2024-11-17], description: "Test expense"}

    assert :ok == Store.add_expense("user1", expense)

    [added_expense] = Store.get_expenses("user1")
    assert added_expense == expense
  end

  test "get_expenses/1 returns an empty list for a new user" do
    Store.add_username("user1")
    assert Store.get_expenses("user1") == []
  end

  test "get_expenses/1 returns a list of expenses for an existing user" do
    Store.add_username("user1")
    expense1 = %{amount: 50, date: ~D[2024-11-17], description: "Groceries"}
    expense2 = %{amount: 200, date: ~D[2024-11-17], description: "Rent"}

    Store.add_expense("user1", expense1)
    Store.add_expense("user1", expense2)

    expenses = Store.get_expenses("user1")
    assert length(expenses) == 2
    assert expense1 in expenses
    assert expense2 in expenses
  end
end
