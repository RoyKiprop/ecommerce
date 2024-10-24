defmodule EcommerceWeb.PaymentsLive.CheckoutLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Cart

  def mount(_params, _session, socket) do
    cart_items = Cart.get_cart(socket.assigns.current_user.id).order_items
    cart = Cart.get_cart(socket.assigns.current_user.id)

    {:ok,
     assign(socket,
       cart_items: cart_items,
       cart: cart,
       form: to_form(%{}),
       selected_payment_method: nil
     )}
  end

  def handle_event("select_payment_method", %{"value" => method}, socket) do
    {:noreply, assign(socket, selected_payment_method: method)}
  end
end
