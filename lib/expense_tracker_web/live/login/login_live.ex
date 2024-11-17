defmodule ExpenseTrackerWeb.LoginLive do
  use ExpenseTrackerWeb, :live_view

  alias ExpenseTracker.Store

  def mount(_params, _session, socket) do
    {:ok, assign(socket, username: "", error: nil)}
end

  def handle_event("validate_username", %{"username" => username}, socket) do
    if username == "" do
      {:noreply, assign(socket, error: "Username cannot be empty")}
    else
      if Store.unique_username?(username) do
        {:noreply, assign(socket, error: nil)}
      else
        {:noreply, assign(socket, error: "Username already taken")}
      end
    end
  end

  def handle_event("login", %{"username" => username}, socket) do
    if username == "" do
      {:noreply, assign(socket, error: "Username cannot be empty")}
    else
      if Store.unique_username?(username) do
        Store.add_username(username)
        {:noreply, push_navigate(socket, to: "/expenses?username=#{username}")}
      else
        {:noreply, assign(socket, error: "Username already taken")}
      end
    end
  end
end
