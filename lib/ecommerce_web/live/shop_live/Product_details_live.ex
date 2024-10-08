defmodule EcommerceWeb.ShopLive.ProductDetailsLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Products

  def mount(%{"id" => id}, _session, socket) do
    product = Products.get_product!(id)
    {:ok, assign(socket, product: product)}
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
        <!-- Quantity Control and Add to Cart -->
        <div class="flex items-center mb-6 space-x-4">
          <button
            phx-click=""
            phx-value-id={@product.id}
            class="bg-[#fe735e] text-white font-semibold py-2 px-6 rounded-lg hover:bg-[#fe6a4f] transition-colors duration-200"
          >
            Add to Cart
          </button>
        </div>
        <div class="mt-6 space-y-4">
          <!-- Secure Payments -->
          <div class="flex items-center space-x-2">
            <p class="font-semibold text-gray-600">
              Secure payments with Mpesa, credit, or debit card
            </p>
          </div>
          <!-- Fast Delivery -->
          <div class="flex items-center space-x-2">
            <p class="font-semibold text-gray-600">Fast and free delivery within Nairobi</p>
          </div>
          <!-- Best Quality -->
          <div class="flex items-center space-x-2">
            <p class="font-semibold text-gray-600">Best quality you can ever ask for</p>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
