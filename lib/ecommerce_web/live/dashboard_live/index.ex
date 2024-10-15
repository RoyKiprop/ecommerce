defmodule EcommerceWeb.DashboardLive.Index do
  use EcommerceWeb, :admin_live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
