defmodule Ecommerce.Order_Items do
  @moduledoc """
  The Order_Items context.
  """

  import Ecto.Query, warn: false
  alias Ecommerce.Repo

  alias Ecommerce.Order_Items.Order_Item
  alias Ecommerce.Orders.Order

  def total_cart(user_id) do
    %Order_Item{}
    |> join(:inner, [oi], o in Order, on: oi.order_id == o.id)
    |> where([oi, o], o.user_id == ^user_id)
    |> select([oi], count(oi.id))
    |> Repo.one()
  end

  @doc """
  Returns the list of order_items.

  ## Examples

      iex> list_order_items()
      [%Order_Item{}, ...]

  """
  def list_order_items do
    Repo.all(Order_Item)
  end

  @doc """
  Gets a single order__item.

  Raises `Ecto.NoResultsError` if the Order  item does not exist.

  ## Examples

      iex> get_order__item!(123)
      %Order_Item{}

      iex> get_order__item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order__item!(id), do: Repo.get!(Order_Item, id)

  @doc """
  Creates a order__item.

  ## Examples

      iex> create_order__item(%{field: value})
      {:ok, %Order_Item{}}

      iex> create_order__item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order__item(attrs \\ %{}) do
    %Order_Item{}
    |> Order_Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order__item.

  ## Examples

      iex> update_order__item(order__item, %{field: new_value})
      {:ok, %Order_Item{}}

      iex> update_order__item(order__item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order__item(%Order_Item{} = order__item, attrs) do
    order__item
    |> Order_Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order__item.

  ## Examples

      iex> delete_order__item(order__item)
      {:ok, %Order_Item{}}

      iex> delete_order__item(order__item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order__item(%Order_Item{} = order__item) do
    Repo.delete(order__item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order__item changes.

  ## Examples

      iex> change_order__item(order__item)
      %Ecto.Changeset{data: %Order_Item{}}

  """
  def change_order__item(%Order_Item{} = order__item, attrs \\ %{}) do
    Order_Item.changeset(order__item, attrs)
  end
end
