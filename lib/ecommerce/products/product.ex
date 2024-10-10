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
    field :discount, :decimal
    field :stock, :integer

    belongs_to :category, Ecommerce.Products.Category
    has_many :order_items, Ecommerce.Order_Items.Order_Item

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :name,
      :description,
      :price,
      :currency,
      :color,
      :image,
      :stock,
      :category_id,
      :discount
    ])
    |> validate_required([:name, :description, :price, :currency, :color, :image, :stock])
  end
end
