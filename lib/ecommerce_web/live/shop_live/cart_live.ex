defmodule EcommerceWeb.CartLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Cart

  def mount(_params, _session, socket) do
    cart_items = Cart.get_cart(socket.assigns.current_user.id).order_items
    cart_count = Cart.count_cart_items(socket.assigns.current_user.id)

    {:ok,
     assign(socket,
       cart_items: cart_items,
       cart_count: cart_count,
       promo_code: ""
     )}
  end

  def handle_event("update_quantity", %{"id" => id, "value" => quantity}, socket) do
    user_id = socket.assigns.current_user.id
    quantity = String.to_integer(quantity)
    IO.inspect(quantity)

    case Cart.change_quantity(id, user_id, quantity) do
      {:ok, message} ->
        updated_cart_items = Cart.get_cart(user_id).order_items
        updated_cart_count = Cart.count_cart_items(user_id)

        {:noreply,
         socket
         |> put_flash(:info, message)
         |> assign(cart_items: updated_cart_items, cart_count: updated_cart_count)}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to update item: #{reason}")}
    end
  end

  def handle_event("remove_item", %{"id" => id}, socket) do
    user_id = socket.assigns.current_user.id

    case Cart.delete_cart_item(id, user_id) do
      {:ok, message} ->
        cart_items = Cart.get_cart(user_id).order_items
        cart_count = Cart.count_cart_items(user_id)

        {:noreply,
         socket
         |> put_flash(:info, message)
         |> assign(cart_items: cart_items, cart_count: cart_count)}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to delete item: #{reason}")}
    end
  end

  def handle_event("apply_promo_code", %{"promo_code" => promo_code}, socket) do
    # Logic to apply promo code
    {:noreply, assign(socket, :promo_code, promo_code)}
  end

  def render(assigns) do
    ~H"""
    <.modal id="cart">
      <div
        id="cart-modal"
        class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
      >
        <div class="w-full max-w-7xl bg-white p-6 shadow-xl rounded-xl relative max-h-[95vh] overflow-y-auto custom-scrollbar">
          <div class="relative border-b flex items-center justify-between pb-4">
            <h2 class="text-2xl font-semibold mb-4">
              Items
              <div class="absolute top-[-12px] left-[55px] bg-blue-500 text-white rounded-full h-6 w-6 flex items-center justify-center text-xs">
                <%= @cart_count %>
              </div>
            </h2>
            <button phx-click={JS.patch(~p"/shop")} class="text-black">
              <i class="bi bi-x-lg text-2xl"></i>
            </button>
          </div>
          <!-- Cart Items -->
          <%= for item <- @cart_items do %>
            <div class="flex items-center space-x-4 border-b p-5 mb-4">
              <img
                src={item.product.image}
                alt={item.product.name}
                class="w-20 h-20 rounded-lg object-cover"
              />
              <div class="w-full space-y-2">
                <div class="flex justify-between">
                  <h3 class="text-lg font-semibold"><%= item.product.name %></h3>
                  <div class="flex space-x-5 items-center">
                    <button
                      phx-click="remove_item"
                      phx-value-id={item.product.id}
                      class="text-gray-600 hover:text-red-800"
                    >
                      <i class="bi bi-trash"></i>
                    </button>
                  </div>
                </div>
                <p class="text-gray-500">Color: <%= item.product.color %></p>
                <div class="flex items-center justify-between mt-2">
                  <input
                    type="number"
                    min="1"
                    value={item.quantity}
                    phx-blur="update_quantity"
                    phx-value-id={item.product.id}
                    class="w-16 p-1 border border-gray-300 rounded-lg"
                  />
                  <p class="text-black text-xl font-semibold">
                    <%= item.product.currency %>&nbsp;<%= item.price %>
                  </p>
                </div>
              </div>
            </div>
          <% end %>
          <!-- Subtotal, Promo Code, and Checkout -->
          <div class="p-5 mt-4">
            <p class="text-lg text-black font-medium">SubTotal</p>
            <!-- Display subtotal here -->
          </div>

          <div class="mt-4 p-5">
            <label for="promo_code" class="block mb-2">Promo code</label>
            <input
              type="text"
              id="promo_code"
              placeholder="Enter your promo code"
              value={@promo_code}
              class="w-full p-2 border border-gray-300 rounded-lg mb-4"
              phx-change="apply_promo_code"
            />
            <button class="bg-blue-700 text-white py-2 px-6 rounded-lg w-full">
              Proceed to checkout
            </button>
          </div>
        </div>
      </div>
    </.modal>
    """
  end
end
