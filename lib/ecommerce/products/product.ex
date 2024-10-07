defmodule Ecommerce.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :image, :string
    field :currency, :string
    field :color, :string
    field :price, :decimal
    field :stock, :integer
    belongs_to :category, Ecommerce.Products.Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :currency, :color, :image, :stock, :category_id])
    |> validate_required([:name, :description, :price, :currency, :color, :image, :stock])
  end
end
