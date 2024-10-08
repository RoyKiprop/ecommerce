defmodule Ecommerce.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ecommerce.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        discount: "120.5",
        shipping: "120.5",
        status: "some status",
        sub_total: "120.5",
        tax: "120.5",
        total: "120.5"
      })
      |> Ecommerce.Orders.create_order()

    order
  end
end
