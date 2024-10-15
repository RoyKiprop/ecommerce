defmodule EcommerceWeb.ExclusiveDealLive.Show do
  use EcommerceWeb, :admin_live_view

  alias Ecommerce.Products

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:exclusive_deal, Products.get_exclusive_deal!(id))}
  end

  defp page_title(:show), do: "Show Exclusive deal"
  defp page_title(:edit), do: "Edit Exclusive deal"
end
