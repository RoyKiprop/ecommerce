defmodule Ecommerce.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :quantity, :integer
      add :price, :decimal
      add :currecny, :string

      timestamps(type: :utc_datetime)
    end
  end
end
