defmodule Ecommerce.Products.ExclusiveDeal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exclusive_deals" do
    field :active, :boolean, default: false
    field :title, :string
    field :description, :string
    field :start_date, :naive_datetime
    field :end_date, :naive_datetime
    field :discount, :decimal
    belongs_to :product, Ecommerce.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(exclusive_deal, attrs) do
    exclusive_deal
    |> cast(attrs, [:title, :description, :start_date, :end_date, :discount, :active, :product_id])
    |> validate_required([:title, :description, :start_date, :end_date, :discount, :active])
  end
end
