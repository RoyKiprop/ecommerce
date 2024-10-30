defmodule EcommerceWeb.HeaderComponent do
  use Phoenix.Component
  alias EcommerceWeb.JSHelpers
  import EcommerceWeb.CoreComponents

  def logo(assigns) do
    ~H"""
    <div>
      <h1 class="font-bold text-2xl">ELECTRONICS</h1>
    </div>
    """
  end

  def filter(assigns) do
    ~H"""
    <div class="flex items-center w-full max-w-xl">
      <div class="relative flex w-full">
        <.form for={%{}} phx-change="search" phx-submit="submit" class="w-full h-auto">
          <.input
            phx-debounce="300"
            value=""
            name="search"
            type="text"
            placeholder="What are you looking for?"
            class="w-full pl-4 pr-16 py-5 rounded-lg border-2 border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-600 bg-black text-white"
          />

          <.button class="absolute right-0 top-1/2 transform -translate-y-1/2   bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700">
            <i class="fas fa-search"></i>
          </.button>
        </.form>
      </div>
    </div>
    """
  end

  def user(assigns) do
    ~H"""
    <div class="relative">
      <button
        class="img-down"
        type="button"
        id="user-menu-button"
        phx-click={JSHelpers.toggle_dropdown()}
      >
        <i class="fa-regular fa-user fa-2x"></i>
      </button>

      <div
        id="dropdown-menu"
        phx-click-away={JSHelpers.toggle_dropdown()}
        class="absolute right-0 mt-2 p-4 w-[150px] bg-white rounded-lg shadow-xl text-sm border border-white z-50"
        hidden
      >
        <%= if @current_user do %>
          <div class="flex flex-col space-y-2">
            <.link
              navigate="/users/settings"
              class="  pb-3 border-gray-500 "
              role="menuitem"
              tabindex="-1"
              method="get"
            >
              My Account
            </.link>

            <.link href="#" class="  pb-3 border-gray-500" role="menuitem" tabindex="-1" method="get">
              Settings
            </.link>
            <.link navigate="/users/log_in" class="" role="menuitem" tabindex="-1" method="get">
              Sign Out
            </.link>
          </div>
        <% else %>
          <div class="flex flex-col space-y-2">
            <.link
              navigate="/users/log_in"
              class="  pb-3 border-gray-500"
              role="menuitem"
              tabindex="-1"
              method="get"
            >
              Sign In
            </.link>
            <.link navigate="/users/register" class="" role="menuitem" tabindex="-1" method="get">
              Register
            </.link>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def cart(assigns) do
    ~H"""
    <.link patch="/cart">
      <div class="relative inline-block">
        <!-- Cart Icon with Cart Count -->
        <img src="/images/image.png" class="h-8 w-8 cursor-pointer" />
        <!-- Cart count badge -->
        <div class="absolute top-0 right-[-18px] -mt-5 bg-blue-500 text-white rounded-full h-6 w-6 flex items-center justify-center text-xs">
          <%= @cart_count %>
        </div>
      </div>
    </.link>
    """
  end

  def category(assigns) do
    ~H"""
    <div class="relative"></div>
    """
  end

  def navigation(assigns) do
    ~H"""
    <div>
      <ul class="flex items-center gap-10">
        <li>
          <.link
            navigate="/"
            class="text-black hover:text-blue-800 focus:text-blue-800"
            role="navigation"
            method="get"
          >
            Home
          </.link>
        </li>

        <li>
          <.link
            navigate="/shop"
            class="text-black hover:text-blue-800 focus:text-blue-800"
            role="navigation"
            method="get"
          >
            Shop
          </.link>
        </li>

        <li>
          <.link
            href="/about"
            class="text-black hover:text-blue-800 focus:text-blue-800"
            role="navigation"
            method="get"
          >
            About Us
          </.link>
        </li>

        <li>
          <.link
            href="/contact"
            class="text-black hover:text-blue-800 focus:text-blue-800"
            role="navigation"
            method="get"
          >
            Contact Us
          </.link>
        </li>
      </ul>
    </div>
    """
  end

  def flash_sale(assigns) do
    ~H"""
    <div class="flex items-center"></div>
    """
  end
end
