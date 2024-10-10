defmodule Ecommerce.Order_ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ecommerce.Order_Items` context.
  """

  @doc """
  Generate a order__item.
  """
  def order__item_fixture(attrs \\ %{}) do
    {:ok, order__item} =
      attrs
      |> Enum.into(%{
        currecny: "some currecny",
        price: "120.5",
        quantity: 42
      })
      |> Ecommerce.Order_Items.create_order__item()

    order__item
  end
end
