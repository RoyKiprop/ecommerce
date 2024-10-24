defmodule Ecommerce.Payment do
  alias Ecommerce.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :decimal
    field :currency, :string, default: "KES"
    field :phone, :string
    field :payment_method, :string
    field :status, :string, default: "pending"
    field :transaction_id, :string

    belongs_to :order, Ecommerce.Orders.Order
    belongs_to :user, Ecommerce.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [
      :amount,
      :currency,
      :phone,
      :payment_method,
      :status,
      :transaction_id,
      :order_id
    ])
    |> validate_required([:amount, :payment_method, :status, :order_id])
    |> validate_inclusion(:status, ["pending", "completed", "failed"])
    |> assoc_constraint(:order)
    |> assoc_constraint(:user)
  end

  def create_payment(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end
end
