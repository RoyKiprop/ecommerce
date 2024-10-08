defmodule Ecommerce.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :status, :string
      add :sub_total, :decimal
      add :discount, :decimal
      add :tax, :decimal
      add :shipping, :decimal
      add :total, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
