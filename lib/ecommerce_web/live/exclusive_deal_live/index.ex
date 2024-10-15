defmodule EcommerceWeb.ExclusiveDealLive.Index do
  use EcommerceWeb, :admin_live_view

  alias Ecommerce.Products
  alias Ecommerce.Products.ExclusiveDeal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :exclusive_deals, Products.list_exclusive_deals())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Exclusive deal")
    |> assign(:exclusive_deal, Products.get_exclusive_deal!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Exclusive deal")
    |> assign(:exclusive_deal, %ExclusiveDeal{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Exclusive deals")
    |> assign(:exclusive_deal, nil)
  end

  @impl true
  def handle_info(
        {EcommerceWeb.ExclusiveDealLive.FormComponent, {:saved, exclusive_deal}},
        socket
      ) do
    {:noreply, stream_insert(socket, :exclusive_deals, exclusive_deal)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    exclusive_deal = Products.get_exclusive_deal!(id)
    {:ok, _} = Products.delete_exclusive_deal(exclusive_deal)

    {:noreply, stream_delete(socket, :exclusive_deals, exclusive_deal)}
  end
end
