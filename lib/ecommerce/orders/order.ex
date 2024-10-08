defmodule Ecommerce.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :status, :string
    field :total, :decimal
    field :sub_total, :decimal
    field :discount, :decimal
    field :tax, :decimal
    field :shipping, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status, :sub_total, :discount, :tax, :shipping, :total])
    |> validate_required([:status, :sub_total, :discount, :tax, :shipping, :total])
  end
end
