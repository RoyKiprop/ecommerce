defmodule EcommerceWeb.PageController do
  use EcommerceWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/home")
  end
end
