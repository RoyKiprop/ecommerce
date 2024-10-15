defmodule Ecommerce.Repo.Migrations.CreateExclusiveDeals do
  use Ecto.Migration

  def change do
    create table(:exclusive_deals) do
      add :title, :string
      add :description, :text
      add :start_date, :naive_datetime
      add :end_date, :naive_datetime
      add :discount, :decimal
      add :active, :boolean, default: false, null: false
      add :product_id, references(:products, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:exclusive_deals, [:product_id])
  end
end
