defmodule EcommerceWeb.HomeLive do
  alias Ecommerce.Repo
  alias Ecommerce.Products
  use EcommerceWeb, :live_view
  alias Ecommerce.Products.{ExclusiveDeal, Product}

  # Auto-slide every 5 seconds
  @interval 5000

  def mount(_params, _session, socket) do
    exclusive_deals =
      Products.list_exclusive_deals()
      |> Repo.preload(:product)

    # Start the auto-slide timer if connected
    if connected?(socket), do: :timer.send_interval(@interval, self(), :auto_slide)

    {:ok,
     assign(socket,
       slides: exclusive_deals,
       current_slide: 0,
       slide_active: 0,
       auto_slide_active: true
     )}
  end

  def handle_info(:auto_slide, socket) do
    # Move to the next slide, stop at the last slide without looping
    next_slide = socket.assigns.current_slide + 1

    if next_slide < length(socket.assigns.slides) do
      {:noreply, assign(socket, current_slide: next_slide, slide_active: nil)}
    else
      # Stop auto-sliding at the last slide
      {:noreply, assign(socket, auto_slide_active: false)}
    end
  end

  def handle_event("goto_slide", %{"index" => index}, socket) do
    index = String.to_integer(index)
    {:noreply, assign(socket, current_slide: index, slide_active: nil)}
  end

  def handle_event("slide_changed", _params, socket) do
    # Once the slide transition is done, trigger the animations
    {:noreply, assign(socket, slide_active: socket.assigns.current_slide)}
  end
end
