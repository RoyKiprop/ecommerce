defmodule EcommerceWeb.CartLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Cart

  def mount(_params, _session, socket) do
    cart_items = Cart.get_cart(socket.assigns.current_user.id).order_items
    cart_count = Cart.count_cart_items(socket.assigns.current_user.id)
    cart_subtotal = Cart.get_cart_subtotal(socket.assigns.current_user.id)

    {:ok,
     assign(socket,
       cart_items: cart_items,
       cart_count: cart_count,
       cart_subtotal: cart_subtotal,
       promo_code: ""
     )}
  end

  def handle_event("update_quantity", %{"id" => id, "value" => quantity}, socket) do
    user_id = socket.assigns.current_user.id
    quantity = String.to_integer(quantity)

    case Cart.change_quantity(id, user_id, quantity) do
      {:ok, message} ->
        updated_cart_items = Cart.get_cart(user_id).order_items
        updated_cart_count = Cart.count_cart_items(user_id)

        # Recalculate and get the updated cart subtotal

        {:noreply,
         socket
         |> put_flash(:info, message)
         |> assign(
           cart_items: updated_cart_items,
           cart_count: updated_cart_count
         )}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to update item: #{reason}")}
    end
  end

  def handle_event("remove_item", %{"id" => id}, socket) do
    user_id = socket.assigns.current_user.id

    case Cart.delete_cart_item(id, user_id) do
      {:ok, message} ->
        updated_cart_items = Cart.get_cart(user_id).order_items
        updated_cart_count = Cart.count_cart_items(user_id)
        # Recalculate and get the updated cart subtotal
        {:ok, updated_cart_subtotal} = Cart.cart_subtotal(user_id)

        {:noreply,
         socket
         |> put_flash(:info, message)
         |> assign(
           cart_items: updated_cart_items,
           cart_count: updated_cart_count,
           cart_subtotal: updated_cart_subtotal
         )}

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
                  <div class="flex flex-col sm:flex-row items-center border border-gray-300 rounded-md w-max bg-gray-100">
                    <!-- Decrease Button -->
                    <button
                      phx-click="decrease_quantity"
                      phx-value-id={item.product.id}
                      class="px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-600 rounded-l-md sm:rounded-l-none sm:rounded-t-md focus:outline-none"
                    >
                      -
                    </button>
                    <!-- Quantity Display -->
                    <span class="px-4 py-2 bg-white text-gray-700 text-sm font-semibold  sm:border-l sm:border-r sm:border-gray-300">
                      <%= item.quantity %>
                    </span>
                    <!-- Increase Button -->
                    <button
                      phx-click="increase_quantity"
                      phx-value-id={item.product.id}
                      class="px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-600 rounded-r-md sm:rounded-r-none sm:rounded-b-md focus:outline-none"
                    >
                      +
                    </button>
                  </div>

                  <div class="flex space-x-8">
                    <p class="font-semibold text-red-600 text-xl text-left thick-strike">
                      <%= item.product.currency %> <%= item.price %>
                    </p>
                    <p class="font-semibold text-green-600 text-xl text-left">
                      <%= item.product.currency %> <%= item.discounted_price %>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          <% end %>
          <!-- Subtotal, Promo Code, and Checkout -->
          <%= if @cart_count > 0 do %>
            <div>
              <div class="p-5 mt-4 flex items-center justify-between">
                <p class="text-lg text-black font-bold">SubTotal</p>
                <p class="text-xl font-bold">KES <%= @cart_subtotal %></p>
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
          <% else %>
            <div class="flex flex-col items-center justify-center h-[50vh]">
              <h2 class="text-2xl font-semibold mb-4">You Have No Products In The Cart</h2>
              <!-- Icons would go here -->
              <div class="flex justify-center space-x-4 mb-4">
                <!-- Add the icons here as <i> or <svg> tags when needed -->
              </div>
              <.link navigate={~p"/shop"}>
                <button class="bg-black text-white px-6 py-2 rounded-lg hover:bg-gray-800">
                  Shop For Products
                </button>
              </.link>
            </div>
          <% end %>
        </div>
      </div>
    </.modal>
    """
  end
end
