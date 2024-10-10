defmodule EcommerceWeb.ShopLive.ProductDetailsLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Products
  alias Ecommerce.Cart
  alias Ecommerce.Accounts

  def mount(%{"id" => id}, session, socket) do
    product = Products.get_product!(id)

    current_user =
      case session["user_token"] do
        nil ->
          nil

        token ->
          Accounts.get_user_by_session_token(token)
      end

    # Initialize total_items to 0 if there's no user or no cart
    total_items =
      case current_user do
        nil -> 0
        %{} -> Cart.count_cart_items(current_user.id)
      end

    # Assign product, current_user, and total_items to the socket
    {:ok, assign(socket, product: product, current_user: current_user, total_items: total_items)}
  end

  def handle_event("add-to-cart", %{"id" => id}, socket) do
    case socket.assigns.current_user do
      nil ->
        {:noreply, put_flash(socket, :error, "You must be logged in to add items to the cart.")}

      %{} = current_user ->
        user_id = current_user.id

        # Add item to cart and update total_items after successful addition
        case Cart.add_item_to_cart(user_id, id) do
          {:ok, message} ->
            IO.inspect(message, label: "Item added to cart successfully")
            total_items = Cart.count_cart_items(user_id)
            {:noreply, assign(socket, :total_items, total_items)}

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

      <div class="w-full lg:w-1/2">
        <h1 class="text-3xl font-semibold text-gray-800 mb-4"><%= @product.name %></h1>

        <p class="text-xl text-[#fe735e] font-bold mb-4">
          Price: <%= @product.price %> <%= @product.currency %>
        </p>

        <p class="text-gray-600 mb-6 leading-relaxed">
          <%= @product.description %>
        </p>

        <div class="flex items-center mb-6 space-x-4">
          <button
            phx-click="add-to-cart"
            phx-value-id={@product.id}
            class="bg-[#fe735e] text-white font-semibold py-2 px-6 rounded-lg hover:bg-[#fe6a4f] transition-colors duration-200"
          >
            Add to Cart
          </button>
          <span>Items in cart: <%= @total_items %></span>
        </div>
      </div>
    </div>
    """
  end
end
