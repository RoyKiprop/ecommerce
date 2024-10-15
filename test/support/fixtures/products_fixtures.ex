defmodule Ecommerce.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ecommerce.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        color: "some color",
        currency: "some currency",
        description: "some description",
        image: "some image",
        name: "some name",
        price: "120.5",
        stock: 42
      })
      |> Ecommerce.Products.create_product()

    product
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Ecommerce.Products.create_category()

    category
  end

  @doc """
  Generate a exclusive_deal.
  """
  def exclusive_deal_fixture(attrs \\ %{}) do
    {:ok, exclusive_deal} =
      attrs
      |> Enum.into(%{
        active: true,
        description: "some description",
        discount: "120.5",
        end_date: ~N[2024-10-14 02:37:00],
        name: "some name",
        start_date: ~N[2024-10-14 02:37:00]
      })
      |> Ecommerce.Products.create_exclusive_deal()

    exclusive_deal
  end
end
