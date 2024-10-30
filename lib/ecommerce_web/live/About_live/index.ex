defmodule EcommerceWeb.AboutLive.Index do
  use EcommerceWeb, :live_view
  alias Ecommerce.Cart

  def mount(_params, _session, socket) do
    current_user = socket.assigns[:current_user]

    cart_count =
      if current_user do
        Cart.count_cart_items(current_user.id)
      else
        0
      end

    {:ok, assign(socket, cart_count: cart_count)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-b from-gray-50 to-white">
      <!-- Hero Section - Improved responsiveness -->
      <section class="relative overflow-hidden bg-gradient-to-r from-blue-600 to-indigo-700 py-12 sm:py-16 md:py-20">
        <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="text-center">
            <h1 class="text-xl sm:text-2xl md:text-3xl lg:text-4xl font-bold text-white mb-4 sm:mb-6">
              Elevating Your iPhone Experience
            </h1>
            <p class="text-sm sm:text-base text-gray-200 max-w-3xl mx-auto px-4 sm:px-6">
              More than just a store, we are your trusted partner in finding the perfect iPhone that matches your lifestyle.
            </p>
          </div>
        </div>
      </section>
      <!-- Main Content - Improved spacing and responsiveness -->
      <section class="py-8 sm:py-12 md:py-16 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Our Story - Enhanced grid layout -->
        <div class="mb-12 sm:mb-16 md:mb-20">
          <h2 class="text-2xl sm:text-3xl font-semibold text-black mb-6 sm:mb-8 text-center">
            Our Story
          </h2>
          <div class="grid md:grid-cols-2 gap-8 md:gap-12 items-center">
            <div class="space-y-4 sm:space-y-6">
              <p class="text-base sm:text-lg text-black font-light">
                Founded in 2020, iPhoneStore emerged from a simple vision: to make premium iPhone technology accessible to everyone while providing exceptional service.
              </p>
              <p class="text-base sm:text-lg text-black font-light">
                Today, we have served over 10,000 happy customers and continue to grow, guided by our commitment to authenticity and customer satisfaction.
              </p>
            </div>
            <div class="bg-gradient-to-br from-gray-100 to-gray-200 p-4 sm:p-6 md:p-8 rounded-2xl shadow-lg">
              <div class="grid grid-cols-2 gap-3 sm:gap-4 text-center">
                <div class="p-3 sm:p-4 bg-white rounded-xl shadow-sm">
                  <p class="text-2xl sm:text-3xl font-bold text-blue-800">10K+</p>
                  <p class="text-sm sm:text-base text-black font-light">Happy Customers</p>
                </div>
                <div class="p-3 sm:p-4 bg-white rounded-xl shadow-sm">
                  <p class="text-2xl sm:text-3xl font-bold text-blue-800">100%</p>
                  <p class="text-sm sm:text-base text-black font-light">Genuine Products</p>
                </div>
                <div class="p-3 sm:p-4 bg-white rounded-xl shadow-sm">
                  <p class="text-2xl sm:text-3xl font-bold text-blue-800">24/7</p>
                  <p class="text-sm sm:text-base text-black font-light">Support</p>
                </div>
                <div class="p-3 sm:p-4 bg-white rounded-xl shadow-sm">
                  <p class="text-2xl sm:text-3xl font-bold text-blue-800">98%</p>
                  <p class="text-sm sm:text-base text-black font-light">Satisfaction Rate</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Why Choose Us - Improved card layout -->
        <div class="bg-gradient-to-br from-gray-50 to-blue-50 rounded-2xl sm:rounded-3xl p-6 sm:p-8 md:p-12">
          <h2 class="text-2xl sm:text-3xl font-bold text-black mb-8 sm:mb-12 text-center">
            Why Choose Us
          </h2>
          <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8">
            <div class="bg-white rounded-xl p-4 sm:p-6 shadow-sm hover:shadow-md transition-shadow duration-300">
              <div class="w-10 h-10 sm:w-12 sm:h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4 mx-auto">
                <svg
                  class="w-5 h-5 sm:w-6 sm:h-6 text-blue-600"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                  >
                  </path>
                </svg>
              </div>
              <h3 class="text-lg sm:text-xl font-semibold text-black text-center mb-2">
                Quality Guaranteed
              </h3>
              <p class="text-sm sm:text-base text-black font-light text-center">
                Every iPhone comes with Apple's official warranty and our additional quality assurance checks.
              </p>
            </div>

            <div class="bg-white rounded-xl p-4 sm:p-6 shadow-sm hover:shadow-md transition-shadow duration-300">
              <div class="w-10 h-10 sm:w-12 sm:h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4 mx-auto">
                <svg
                  class="w-5 h-5 sm:w-6 sm:h-6 text-blue-600"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M13 10V3L4 14h7v7l9-11h-7z"
                  >
                  </path>
                </svg>
              </div>
              <h3 class="text-lg sm:text-xl font-semibold text-black text-center mb-2">
                Fast Delivery
              </h3>
              <p class="text-sm sm:text-base text-black font-light text-center">
                Express shipping nationwide with real-time tracking and secure packaging.
              </p>
            </div>

            <div class="bg-white rounded-xl p-4 sm:p-6 shadow-sm hover:shadow-md transition-shadow duration-300">
              <div class="w-10 h-10 sm:w-12 sm:h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4 mx-auto">
                <svg
                  class="w-5 h-5 sm:w-6 sm:h-6 text-blue-600"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"
                  >
                  </path>
                </svg>
              </div>
              <h3 class="text-lg sm:text-xl font-semibold text-black text-center mb-2">
                Expert Support
              </h3>
              <p class="text-sm sm:text-base text-black font-light text-center">
                Our tech experts are available 24/7 to help with any questions or concerns.
              </p>
            </div>
          </div>
        </div>
        <!-- Our Values - Improved spacing -->
        <div class="mt-12 sm:mt-16 md:mt-20 text-center max-w-3xl mx-auto px-4 sm:px-6">
          <h2 class="text-2xl sm:text-3xl font-bold text-black mb-4 sm:mb-6">Our Values</h2>
          <p class="text-sm sm:text-base text-black font-light">
            We believe in transparency, authenticity, and exceptional customer service. Every decision we make is guided by our commitment to these core values.
          </p>
        </div>
      </section>
    </div>
    """
  end
end
