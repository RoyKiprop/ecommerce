defmodule Ecommerce.Repo.Migrations.AddOrderIdToOrderItems do
  use Ecto.Migration

  def change do
    alter table(:order_items) do
      add :order_id, references(:orders, on_delete: :delete_all), null: false
      add :product_id, references(:products, on_delete: :delete_all), null: false
    end

    # Add indexes for faster querying
    create index(:order_items, [:order_id])
    create index(:order_items, [:product_id])
  end
end
