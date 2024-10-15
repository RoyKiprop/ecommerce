defmodule Ecommerce.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Ecommerce.Repo

  alias Ecommerce.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias Ecommerce.Products.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias Ecommerce.Products.ExclusiveDeal

  @doc """
  Returns the list of exclusive_deals.

  ## Examples

      iex> list_exclusive_deals()
      [%ExclusiveDeal{}, ...]

  """
  def list_exclusive_deals do
    Repo.all(ExclusiveDeal)
  end

  @doc """
  Gets a single exclusive_deal.

  Raises `Ecto.NoResultsError` if the Exclusive deal does not exist.

  ## Examples

      iex> get_exclusive_deal!(123)
      %ExclusiveDeal{}

      iex> get_exclusive_deal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exclusive_deal!(id), do: Repo.get!(ExclusiveDeal, id)

  @doc """
  Creates a exclusive_deal.

  ## Examples

      iex> create_exclusive_deal(%{field: value})
      {:ok, %ExclusiveDeal{}}

      iex> create_exclusive_deal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exclusive_deal(attrs \\ %{}) do
    %ExclusiveDeal{}
    |> ExclusiveDeal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a exclusive_deal.

  ## Examples

      iex> update_exclusive_deal(exclusive_deal, %{field: new_value})
      {:ok, %ExclusiveDeal{}}

      iex> update_exclusive_deal(exclusive_deal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exclusive_deal(%ExclusiveDeal{} = exclusive_deal, attrs) do
    exclusive_deal
    |> ExclusiveDeal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a exclusive_deal.

  ## Examples

      iex> delete_exclusive_deal(exclusive_deal)
      {:ok, %ExclusiveDeal{}}

      iex> delete_exclusive_deal(exclusive_deal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exclusive_deal(%ExclusiveDeal{} = exclusive_deal) do
    Repo.delete(exclusive_deal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exclusive_deal changes.

  ## Examples

      iex> change_exclusive_deal(exclusive_deal)
      %Ecto.Changeset{data: %ExclusiveDeal{}}

  """
  def change_exclusive_deal(%ExclusiveDeal{} = exclusive_deal, attrs \\ %{}) do
    ExclusiveDeal.changeset(exclusive_deal, attrs)
  end
end
