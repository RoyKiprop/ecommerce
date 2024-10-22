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
    field :discounted_price, :decimal
    field :stock, :integer

    belongs_to :category, Ecommerce.Products.Category
    has_many :order_items, Ecommerce.Order_Items.Order_Item
    has_many :exclusive_deals, Ecommerce.Products.ExclusiveDeal

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
      :discount,
      :discounted_price
    ])
    |> validate_required([
      :name,
      :description,
      :price,
      :currency,
      :color,
      :image,
      :stock,
      :discount
    ])
    |> calculate_discounted_price()
  end

  defp calculate_discounted_price(changeset) do
    price = get_field(changeset, :price)
    discount = get_field(changeset, :discount)

    if price && discount do
      discounted_price = Decimal.sub(price, discount)
      put_change(changeset, :discounted_price, discounted_price)
    else
      changeset
    end
  end
end
