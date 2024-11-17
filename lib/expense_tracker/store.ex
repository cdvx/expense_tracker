defmodule ExpenseTracker.Store do
  use GenServer
  alias Phoenix.PubSub

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_args) do
    {:ok,  %{expenses: %{}, usernames: MapSet.new()}}
  end

  def add_expense(username, expense) do
    GenServer.call(__MODULE__, {:add_expense, username, expense})
  end

  def get_expenses(username) do
    GenServer.call(__MODULE__, {:get_expenses, username})
  end

  def unique_username?(username) do
    GenServer.call(__MODULE__, {:unique_username, username})
  end

  def add_username(username) do
    GenServer.call(__MODULE__, {:add_username, username})
  end

  def handle_call({:add_expense, username, expense}, _from, state) do
    updated_expenses = Map.update(state.expenses, username, [expense], fn expenses ->
      [expense | expenses]
    end)

    PubSub.broadcast(ExpenseTracker.PubSub, "expenses:#{username}", {:expenses_updated, username})

    {:reply, :ok, %{state | expenses: updated_expenses}}
  end

  def handle_call({:get_expenses, username}, _from, state) do
    expenses = Map.get(state.expenses, username, [])
    {:reply, expenses, state}
  end

  def handle_call({:unique_username, username}, _from, state) do
    IO.inspect(state)
    is_unique = not MapSet.member?(state.usernames, username)
    {:reply, is_unique, state}
  end

  def handle_call({:add_username, username}, _from, state) do
    updated_usernames = MapSet.put(state.usernames, username)
    {:reply, :ok, %{state | usernames: updated_usernames}}
  end
end
