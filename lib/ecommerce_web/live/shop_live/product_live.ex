defmodule EcommerceWeb.ProductLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Products
  alias Ecommerce.Cart

  def mount(_params, _session, socket) do
    products = Products.list_products()
    current_user = socket.assigns[:current_user]

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
       products: products,
       cart_items: cart_items,
       cart_count: cart_count,
       promo_code: "",
       modal_open: false
     )}
  end

  def handle_event("productDetails", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: "/shop/#{id}")}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-32">
      <div class="mt-5 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        <%= for product <- @products do %>
          <div
            phx-click="productDetails"
            phx-value-id={product.id}
            class="relative cursor-pointer border border-gray-300 rounded-lg shadow-sm overflow-hidden transition-all duration-200 hover:border-blue-700"
          >
            <div class="absolute top-0 left-0 bg-red-500 text-white text-xs px-2 py-1 rounded-br-lg z-10">
              On Sale
            </div>
            <!-- Product Image with scaling and background change on hover -->
            <div class="overflow-hidden h-48">
              <img
                src={product.image}
                class="h-full w-full object-cover transition-transform duration-200 hover:scale-110 hover:bg-blue-100"
                alt=""
              />
            </div>

            <div class="p-4">
              <p class="text-gray-900 text-lg mb-2 truncate text-left">
                <%= product.name %>
              </p>

              <div class="mb-2 text-yellow-500 text-left">
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-half"></i>
              </div>

              <p class="font-semibold text-red-600 text-base text-left">
                <%= product.currency %> <%= product.price %>
              </p>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
