defmodule EcommerceWeb.ProductLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Products

  def mount(_params, _session, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products)}
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
            class="cursor-pointer border border-gray-300 rounded-lg shadow-lg overflow-hidden transition-transform duration-200 hover:scale-105"
          >
            <img src={product.image} class="h-48 w-full object-cover" alt="" />
            <div class="p-4">
              <p class="text-gray-700 mb-2 truncate text-left">
                <%= product.name %>
              </p>
              <p class="font-semibold text-[#fe735e] mb-2 text-left">
                <%= product.price %>
                <!-- Adjust according to the currency format if needed -->
              </p>
              <div class="mt-2 text-left">
                <button
                  phx-click="add_to_cart"
                  phx-value-id={product.id}
                  class="bg-[#fe735e] text-white font-bold py-2 px-4 rounded hover:bg-[#fe6a4f] transition-colors duration-200"
                >
                  Add to Cart
                </button>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
