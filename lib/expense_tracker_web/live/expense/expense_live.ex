defmodule ExpenseTrackerWeb.ExpenseLive do
  use ExpenseTrackerWeb, :live_view

  alias Phoenix.PubSub
  alias ExpenseTracker.Store

  def mount(%{"username" => username}, _session, socket) do
    PubSub.subscribe(ExpenseTracker.PubSub, "expenses:#{username}")

    {:ok, assign(socket, username: username, expenses: Store.get_expenses(username), amount: 0.0)}
  end

  # @spec handle_event(<<_::88, _::_*24>>, {map()} | map(), any()) :: {:noreply, any()}
#   def handle_event("add_expense", %{"expense"=> %{"amount" => amount, "date" => date, "description" => description}}, socket) do
#     expense = %{amount: parse_amount(amount), date: date, description: description}
#     Store.add_expense(socket.assigns.username, expense)


#     {:noreply, assign(socket, expenses: [expense | socket.assigns.expenses])}

# end

def handle_event("add_expense", %{"amount" => amount, "date" => date, "description" => description}, socket) do
  expense = %{amount: parse_amount(amount), date: date, description: description}
  Store.add_expense(socket.assigns.username, expense)

  {:noreply, assign(socket, expenses: [expense | socket.assigns.expenses])}
end

def handle_event("add_expense", %{"expense" => %{"amount" => amount, "date" => date, "description" => description}}, socket) do
  expense = %{amount: parse_amount(amount), date: date, description: description}
  Store.add_expense(socket.assigns.username, expense)

  {:noreply, assign(socket, expenses: [expense | socket.assigns.expenses])}
end

  def handle_event("validate_money", %{"amount" => amount}, socket) do
    formatted_amount =
      case parse_amount(amount) do

        :error -> "0.00"
        amount -> amount |> to_string()
      end

    {:noreply, assign(socket, amount: formatted_amount)}
  end

  @spec handle_info(
          {:expenses_updated, any()},
          atom()
          | %{
              :assigns => atom() | %{:username => any(), optional(any()) => any()},
              optional(any()) => any()
            }
        ) :: {:noreply, any()}
  def handle_info({:expenses_updated, username}, socket) do
    if socket.assigns.username == username do
      {:noreply, assign(socket, expenses: Store.get_expenses(username))}
    else
      {:noreply, socket}
    end
  end

  defp parse_amount(string) when is_binary(string) do
    case string |> String.contains?(".") do
      true ->
        Float.parse(string) |> elem(0)
        _ ->
          if String.trim(string) == "", do: :error, else: Integer.parse(string) |> elem(0)

    end
  end
end
