defmodule Ecommerce.Order_Items.Order_Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :quantity, :integer
    field :price, :decimal
    field :currecny, :string
    field :discounted_price, :decimal
    belongs_to :order, Ecommerce.Orders.Order
    belongs_to :product, Ecommerce.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order__item, attrs) do
    order__item
    |> cast(attrs, [:order_id, :product_id, :quantity, :price, :currecny, :discounted_price])
    |> validate_required([:quantity])
  end
end
