defmodule EcommerceWeb.ContactLive.Index do
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
      <!-- Hero Section -->
      <section class="relative py-20 bg-gradient-to-r from-blue-600 to-indigo-700 overflow-hidden">
        <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">Get in Touch</h1>
          <p class="text-base text-blue-100 max-w-2xl mx-auto">
            Have questions about our products or services? We are here to help you find the perfect iPhone.
          </p>
        </div>
      </section>
      <!-- Main Content -->
      <section class="relative -mt-12 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pb-20">
        <div class="grid lg:grid-cols-3 gap-8">
          <!-- Contact Information -->
          <div class="lg:col-span-1">
            <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
              <div class="bg-gradient-to-r from-blue-600 to-indigo-700 px-6 py-8">
                <h3 class="text-2xl font-semibold text-white mb-2">Contact Information</h3>
                <p class="text-blue-100 text-md">
                  Fill out the form and we will get back to you within 24 hours.
                </p>
              </div>
              <div class="px-6 py-8 space-y-8">
                <div class="flex items-center space-x-4">
                  <div class="flex-shrink-0 w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                    <svg
                      class="w-6 h-6 text-blue-600"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
                      >
                      </path>
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
                      >
                      </path>
                    </svg>
                  </div>
                  <div>
                    <p class="text-black  font-medium">Our Location</p>
                    <p class="text-black  font-light ">Nairobi, Kenya</p>
                  </div>
                </div>

                <div class="flex items-center space-x-4">
                  <div class="flex-shrink-0 w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                    <svg
                      class="w-6 h-6 text-blue-600"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
                      >
                      </path>
                    </svg>
                  </div>
                  <div>
                    <p class="text-black  font-medium">Phone</p>
                    <p class="text-black font-light">+254711470560</p>
                  </div>
                </div>

                <div class="flex items-center space-x-4">
                  <div class="flex-shrink-0 w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                    <svg
                      class="w-6 h-6 text-blue-600"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
                      >
                      </path>
                    </svg>
                  </div>
                  <div>
                    <p class="text-black  font-medium">Email</p>
                    <p class="text-black  font-light ">contact@iphonestore.com</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- Contact Form -->
          <div class="lg:col-span-2">
            <div class="bg-white rounded-2xl shadow-lg p-8">
              <form class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <label for="first_name" class="block text-sm font-medium text-gray-700">
                      First Name
                    </label>
                    <input
                      type="text"
                      id="first_name"
                      class="mt-1 block w-full rounded-lg border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 transition duration-150"
                      placeholder="John"
                    />
                  </div>
                  <div>
                    <label for="last_name" class="block text-sm font-medium text-gray-700">
                      Last Name
                    </label>
                    <input
                      type="text"
                      id="last_name"
                      class="mt-1 block w-full rounded-lg border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 transition duration-150"
                      placeholder="Doe"
                    />
                  </div>
                </div>

                <div>
                  <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                  <input
                    type="email"
                    id="email"
                    class="mt-1 block w-full rounded-lg border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 transition duration-150"
                    placeholder="you@example.com"
                  />
                </div>

                <div>
                  <label for="phone" class="block text-sm font-medium text-gray-700">
                    Phone Number
                  </label>
                  <input
                    type="tel"
                    id="phone"
                    class="mt-1 block w-full rounded-lg border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 transition duration-150"
                    placeholder="+1 (555) 000-0000"
                  />
                </div>

                <div>
                  <label for="subject" class="block text-sm font-medium text-gray-700">Subject</label>
                  <select
                    id="subject"
                    class="mt-1 block w-full rounded-lg border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 transition duration-150"
                  >
                    <option>General Inquiry</option>
                    <option>Product Support</option>
                    <option>Order Status</option>
                    <option>Feedback</option>
                  </select>
                </div>

                <div>
                  <label for="message" class="block text-sm font-medium text-gray-700">Message</label>
                  <textarea
                    id="message"
                    rows="4"
                    class="mt-1 block w-full rounded-lg border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 transition duration-150"
                    placeholder="Your message here..."
                  ></textarea>
                </div>

                <div>
                  <button
                    type="submit"
                    class="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-lg text-white bg-gradient-to-r from-blue-600 to-indigo-700 hover:from-blue-700 hover:to-indigo-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-150"
                  >
                    Send Message
                    <svg
                      class="ml-2 -mr-1 w-5 h-5"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M14 5l7 7m0 0l-7 7m7-7H3"
                      >
                      </path>
                    </svg>
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </section>
    </div>
    """
  end
end
