defmodule Ecommerce.Repo.Migrations.AddDiscountToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :discount, :decimal, precision: 5, scale: 2, default: 0.0
    end
  end
end
