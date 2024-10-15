defmodule EcommerceWeb.HeaderComponent do
  use Phoenix.Component
  alias EcommerceWeb.JSHelpers

  def logo(assigns) do
    ~H"""
    <div>
      <h1 class="font-bold text-2xl">ELECTRONICS</h1>
    </div>
    """
  end

  def filter(assigns) do
    ~H"""
    <div class="flex items-center w-full max-w-xl ">
      <div class="relative flex w-full">
        <input
          type="text"
          placeholder="What are you looking for?"
          class="w-full pl-4 pr-12 py-3 rounded-lg border-2 lack focus:outline-none focus:ring-2 focus:ring-blue-600 bg-black text-white"
        />
        <button class="absolute right-2 top-1/2 transform -translate-y-1/2 bg-white py-2 px-4 rounded-md border border-gray-300 hover:bg-gray-200">
          <i class="fas fa-search"></i>
        </button>
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
    <div class="relative">
      <button
        phx-click={JSHelpers.toggle_category()}
        class="text-black hover:text-[#0e64b8] text-sm font-medium focus:text-[#0e64b8]"
      >
        <i class="fa fa-bars" aria-hidden="true"></i> CATEGORIES
      </button>
      <div
        id="category-dropdown"
        class="absolute hidden left-[-24px] mt-1 w-[200px] space-y-12 text-lg bg-gray-400 p-5 rounded-lg"
        phx-click-away={JSHelpers.toggle_category()}
      >
        <div class="flex flex-col space-y-4 text-sm">
          <.link
            href="#"
            class=" pb-3 border-white flex text-center"
            role="menuitem"
            tabindex="-1"
            method="get"
            id="user-menu-item-0"
          >
            Laptops
          </.link>
          <.link
            href="#"
            class=" pb-3 border-white flex items-center"
            role="menuitem"
            tabindex="-1"
            method="get"
            id="user-menu-item-1"
          >
            Samsung
          </.link>
          <.link
            href="#"
            class=" pb-3 border-white flex items-center"
            role="menuitem"
            tabindex="-1"
            method="get"
            id="user-menu-item-2"
          >
            iPhones
          </.link>
          <.link
            href="#"
            class=" pb-3 border-white flex items-center"
            role="menuitem"
            tabindex="-1"
            method="get"
            id="user-menu-item-3"
          >
            Desktop
          </.link>
          <.link
            href="#"
            class="pb-2 flex items-center"
            role="menuitem"
            tabindex="-1"
            method="get"
            id="user-menu-item-4"
          >
            Smart Watches
          </.link>
        </div>
      </div>
    </div>
    """
  end

  def navigation(assigns) do
    ~H"""
    <div>
      <ul class="flex items-center gap-10">
        <li>
          <.link
            navigate="/"
            class="text-black hover:text-[#0e64b8] focus:text-[#0e64b8]"
            role="navigation"
            method="get"
          >
            Home
          </.link>
        </li>

        <li>
          <.link
            navigate="/shop"
            class="text-black hover:text-[#0e64b8] focus:text-[#0e64b8]"
            role="navigation"
            method="get"
          >
            Shop
          </.link>
        </li>

        <li>
          <.link
            href="/"
            class="text-black hover:text-[#0e64b8] focus:text-[#0e64b8]"
            role="navigation"
            method="get"
          >
            About Us
          </.link>
        </li>

        <li>
          <.link
            href="/"
            class="text-black hover:text-[#0e64b8] focus:text-[#0e64b8]"
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
    <div class="flex items-center">
      <span>Exclusive Deals</span>
      <img class="h-10 w-10" src="/images/sales.png" />
    </div>
    """
  end
end
