defmodule EcommerceWeb.ShopLive.ProductDetailsLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Products
  alias Ecommerce.Cart
  alias Ecommerce.Accounts

  def mount(%{"id" => id}, session, socket) do
    product = Products.get_product!(id)

    current_user =
      case session["user_token"] do
        nil -> nil
        token -> Accounts.get_user_by_session_token(token)
      end

    {cart_count, in_cart, item_quantity, cart_items} =
      if current_user do
        cart_count = Cart.count_cart_items(current_user.id)
        in_cart = Cart.item_in_cart?(current_user.id, id)
        item_quantity = if in_cart, do: Cart.get_quantity(current_user.id, id), else: 1
        cart_items = Cart.get_cart(current_user.id).order_items
        {cart_count, in_cart, item_quantity, cart_items}
      else
        {0, false, 0, nil}
      end

    {:ok,
     assign(socket,
       product: product,
       current_user: current_user,
       cart_count: cart_count,
       in_cart: in_cart,
       item_quantity: item_quantity,
       cart_items: cart_items,
       promo_code: ""
     )}
  end

  def handle_event("add-to-cart", %{"id" => id}, socket) do
    case socket.assigns.current_user do
      nil ->
        {:noreply, put_flash(socket, :error, "You must be logged in to add items to the cart.")}

      %{} = current_user ->
        user_id = current_user.id

        case Cart.add_item_to_cart(user_id, id) do
          {:ok, message} ->
            updated_cart_count = Cart.count_cart_items(user_id)
            in_cart = Cart.item_in_cart?(user_id, id)

            {:noreply,
             socket
             |> assign(
               cart_count: updated_cart_count,
               in_cart: in_cart
             )
             |> put_flash(:info, message)}

          {:error, message} ->
            {:noreply, put_flash(socket, :error, message)}
        end
    end
  end

  def handle_event("increase_quantity", %{"id" => id}, socket) do
    user_id = socket.assigns.current_user.id
    id = String.to_integer(id)
    item = Cart.get_item(user_id, id)
    new_quantity = item.quantity + 1

    case Cart.change_quantity(id, user_id, new_quantity) do
      {:ok, _message} ->
        # Get updated quantity directly
        updated_quantity = Cart.get_quantity(user_id, id)

        {:noreply,
         socket
         |> assign(item_quantity: updated_quantity)}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to increase quantity: #{reason}")}
    end
  end

  def handle_event("decrease_quantity", %{"id" => id}, socket) do
    user_id = socket.assigns.current_user.id
    id = String.to_integer(id)
    item = Cart.get_item(user_id, id)
    new_quantity = item.quantity - 1

    if new_quantity > 0 do
      case Cart.change_quantity(id, user_id, new_quantity) do
        {:ok, _message} ->
          # Get updated quantity directly
          updated_quantity = Cart.get_quantity(user_id, id)

          {:noreply,
           socket
           |> assign(item_quantity: updated_quantity)}

        {:error, reason} ->
          {:noreply, put_flash(socket, :error, "Failed to decrease quantity: #{reason}")}
      end
    else
      {:noreply, socket}
    end
  end

  def handle_event("remove-from-cart", %{"id" => id}, socket) do
    user_id = socket.assigns.current_user.id

    case Cart.delete_cart_item(id, user_id) do
      {:ok, message} ->
        updated_cart_items = Cart.get_cart(user_id).order_items
        updated_cart_count = Cart.count_cart_items(user_id)

        {:ok, updated_cart_subtotal} = Cart.cart_subtotal(user_id)

        {:noreply,
         socket
         |> put_flash(:info, message)
         |> assign(
           in_cart: false,
           cart_items: updated_cart_items,
           cart_count: updated_cart_count,
           cart_subtotal: updated_cart_subtotal
         )}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to delete item: #{reason}")}
    end
  end

  def handle_event("continue-shopping", _params, socket) do
    {:noreply, push_navigate(socket, to: "/shop")}
  end

  def handle_event("proceed-to-cart", _params, socket) do
    {:noreply, push_navigate(socket, to: "/cart")}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col lg:flex-row items-center justify-between lg:space-x-12 p-8 max-w-6xl mx-auto">
      <div class="w-full lg:w-1/2 mt-6 lg:mt-0">
        <img
          src={@product.image}
          alt={@product.name}
          class="w-full h-auto rounded-lg shadow-lg object-cover"
        />
      </div>

      <div class="w-full lg:w-1/2 p-8">
        <div class="border-b">
          <h1 class="text-3xl font-semibold text-black mb-2"><%= @product.name %></h1>
          <div class="mb-2 text-yellow-500 text-left flex">
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-half"></i>
          </div>

          <div class="flex items-center space-x-8">
            <p class="font-semibold text-red-600 text-base text-left thick-strike">
              <%= @product.currency %> <%= @product.price %>
            </p>
            <p class="font-semibold text-green-600 text-lg text-left">
              <%= @product.currency %> <%= @product.discounted_price %>
            </p>
          </div>
        </div>

        <p class="text-black font-light text-md my-4">
          <%= @product.description %>
        </p>
        <!-- Conditionally render buttons based on whether the product is in the cart -->
        <%= if @in_cart do %>
          <!-- Cart Buttons (Quantity input, Remove from Cart, Continue Shopping, Proceed to Cart) -->
          <div id="cart-buttons-div" class="flex flex-col space-y-4">
            <div class="flex space-x-5">
              <div class="flex flex-col sm:flex-row items-center border border-gray-300 rounded-md w-max bg-gray-100">
                <!-- Decrease Button -->
                <button
                  phx-click="decrease_quantity"
                  phx-value-id={@product.id}
                  class="px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-600 rounded-l-md sm:rounded-l-none sm:rounded-t-md focus:outline-none"
                >
                  -
                </button>
                <!-- Quantity Display -->
                <span class="px-4 py-2 bg-white text-gray-700 text-sm font-semibold  sm:border-l sm:border-r sm:border-gray-300">
                  <%= @item_quantity %>
                </span>
                <!-- Increase Button -->
                <button
                  phx-click="increase_quantity"
                  phx-value-id={@product.id}
                  class="px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-600 rounded-r-md sm:rounded-r-none sm:rounded-b-md focus:outline-none"
                >
                  +
                </button>
              </div>

              <button
                phx-click="remove-from-cart"
                phx-value-id={@product.id}
                class="bg-red-600 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-red-700 transition-colors duration-200 rounded-lg"
              >
                <i class="bi bi-trash-fill mr-2"></i> Remove from Cart
              </button>
            </div>

            <div class="flex space-x-5">
              <button
                phx-click="continue-shopping"
                class="bg-green-600 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-green-700 transition-colors duration-200 rounded-lg"
              >
                <i class="bi bi-arrow-left-circle-fill mr-2"></i> Continue Shopping
              </button>
              <button
                phx-click="proceed-to-cart"
                class="bg-blue-600 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-blue-700 transition-colors duration-200 rounded-lg"
              >
                <i class="bi bi-arrow-right-circle-fill mr-2"></i> Proceed to Cart
              </button>
            </div>
          </div>
        <% else %>
          <!-- Add to Cart Button -->
          <div id="add-to-cart-div" class="flex items-center mb-6">
            <button
              id="add-cart"
              phx-click="add-to-cart"
              phx-value-id={@product.id}
              class="bg-blue-700 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-black transition-colors duration-200 rounded-lg"
            >
              Add to Cart
            </button>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
