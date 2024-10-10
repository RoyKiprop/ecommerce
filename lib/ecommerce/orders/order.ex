defmodule Ecommerce.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :status, :string, default: "cart"
    field :total, :decimal
    field :sub_total, :decimal
    field :discount, :decimal
    field :tax, :decimal
    field :shipping, :decimal
    has_many :order_items, Ecommerce.Order_Items.Order_Item
    belongs_to :user, Ecommerce.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:user_id, :status, :sub_total, :discount, :tax, :shipping, :total])
    |> validate_required([:status])
  end
end
