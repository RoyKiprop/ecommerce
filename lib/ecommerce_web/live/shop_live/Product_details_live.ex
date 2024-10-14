defmodule EcommerceWeb.ShopLive.ProductDetailsLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Products
  alias Ecommerce.Cart
  alias Ecommerce.Accounts

  def mount(%{"id" => id}, session, socket) do
    # Fetch the product using the provided ID
    product = Products.get_product!(id)

    # Determine the current user based on the session token
    current_user =
      case session["user_token"] do
        nil -> nil
        token -> Accounts.get_user_by_session_token(token)
      end

    {cart_items, cart_count} =
      if current_user do
        case Cart.get_cart(current_user.id) do
          %Ecommerce.Orders.Order{order_items: items} when is_list(items) ->
            {items, length(items)}

          nil ->
            {[], 0}

          _ ->
            {[], 0}
        end
      else
        {[], 0}
      end

    {:ok,
     assign(socket,
       product: product,
       cart_items: cart_items,
       cart_count: cart_count,
       promo_code: "",
       modal_open: false
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
            IO.inspect(message, label: "Item added to cart successfully")

            # Fetch updated cart information
            updated_cart = Cart.get_cart(user_id)
            updated_cart_items = updated_cart.order_items
            updated_cart_count = length(updated_cart_items)

            {:noreply,
             socket
             |> assign(cart_items: updated_cart_items, cart_count: updated_cart_count)
             |> put_flash(:info, "Item added to cart successfully")}

          {:error, message} ->
            IO.inspect(message, label: "Error adding item to cart")
            {:noreply, put_flash(socket, :error, "#{message}")}
        end
    end
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

      <div class="w-full lg:w-1/2  p-8">
        <div class="border-b">
          <h1 class="text-3xl font-semibold text-black mb-2"><%= @product.name %></h1>
          <div class="mb-2 text-yellow-500 text-left flex">
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-fill"></i>
            <i class="bi bi-star-half"></i>
          </div>

          <p class="font-semibold text-red-600 text-base text-left mb-2">
            <%= @product.currency %> <%= @product.price %>
          </p>
        </div>

        <p class="text-black font-light text-md my-4 ">
          <%= @product.description %>
        </p>
        <!-- Quantity input and Remove from Cart button -->
        <div class="hidden flex space-x-5 mb-6">
          <input
            type="number"
            min="1"
            value="1"
            phx-blur="update_quantity"
            phx-value-id={@product.id}
            class="w-1/3 text-center p-2 border border-gray-300 rounded-lg"
          />
          <button
            phx-click="remove-from-cart"
            phx-value-id={@product.id}
            class="bg-red-600 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-red-700 transition-colors duration-200 rounded-lg"
          >
            <i class="bi bi-trash-fill mr-2"></i> Remove from Cart
          </button>
        </div>
        <!-- Add to Cart button -->
        <div class="flex items-center mb-6">
          <button
            phx-click="add-to-cart"
            phx-value-id={@product.id}
            class="bg-blue-700 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-black transition-colors duration-200 rounded-lg"
          >
            Add to Cart
          </button>
        </div>
        <!-- Continue Shopping and Proceed to Cart buttons -->
        <div class="hidden flex space-x-5">
          <button
            phx-click="continue-shopping"
            phx-value-id={@product.id}
            class="bg-green-600 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-green-700 transition-colors duration-200 rounded-lg"
          >
            <i class="bi bi-arrow-left-circle-fill mr-2"></i> Continue Shopping
          </button>
          <button
            phx-click="proceed-to-cart"
            phx-value-id={@product.id}
            class="bg-blue-600 text-white font-semibold py-2 px-6 flex items-center justify-center w-full hover:bg-blue-700 transition-colors duration-200 rounded-lg"
          >
            <i class="bi bi-arrow-right-circle-fill mr-2"></i> Proceed to Cart
          </button>
        </div>
        <!-- Additional Information Section -->
        <div class="mt-6 space-y-4 text-sm">
          <div class="flex items-center space-x-2">
            <i class="bi bi-award text-yellow-500 text-xl"></i>
            <span class="text-black font-light">High Quality Products</span>
          </div>
          <div class="flex items-center space-x-2">
            <i class="bi bi-shield-lock-fill text-green-500 text-xl"></i>
            <span class="text-black font-light">
              Secure Payments with Mpesa, Credit and Debit Card
            </span>
          </div>
          <div class="flex items-center space-x-2">
            <i class="bi bi-truck text-blue-600 text-xl"></i>
            <span class="text-black font-light">Free delivery within Nairobi</span>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
