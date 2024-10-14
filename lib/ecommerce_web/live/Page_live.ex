defmodule EcommerceWeb.PageLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Accounts
  alias Ecommerce.Cart

  @impl true
  def mount(_params, session, socket) do
    current_user =
      case session["user_token"] do
        nil -> nil
        user_token -> Accounts.get_user_by_session_token(user_token)
      end

    total_items =
      case current_user do
        nil -> 0
        %{} -> Cart.count_cart_items(current_user.id)
      end

    socket = assign(socket, total_items: total_items)

    IO.inspect(socket.assigns)

    {:ok, socket}
  end
end
