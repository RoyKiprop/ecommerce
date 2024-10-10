defmodule EcommerceWeb.CartLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Cart

  def mount(_params, _session, socket) do
    cart_items = Cart.get_cart(socket.assigns.current_user.id).order_items
    IO.inspect(cart_items)

    {:ok,
     assign(socket,
       cart_items: cart_items,
       promo_code: "",
       recommended_items: get_recommendations()
     )}
  end

  def handle_event("update_quantity", %{"id" => _id, "quantity" => _quantity}, socket) do
    # Logic to update cart item quantity
    {:noreply, socket}
  end

  def handle_event("remove_item", %{"id" => _id}, socket) do
    # Logic to remove item from cart
    {:noreply, socket}
  end

  def handle_event("apply_promo_code", %{"promo_code" => promo_code}, socket) do
    # Logic to apply promo code
    {:noreply, assign(socket, :promo_code, promo_code)}
  end

  defp get_recommendations() do
    # Return a list of recommended products
    [
      %{id: 1, name: "Product 1", price: 33.00, image: "/images/product1.png"},
      %{id: 2, name: "Product 2", price: 45.00, image: "/images/product2.png"}
    ]
  end
end
