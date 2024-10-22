defmodule Ecommerce.Repo.Migrations.ChangeDiscountDatatype do
  use Ecto.Migration

  def change do
    alter table(:products) do
      modify :discount, :decimal, precision: 10, scale: 2, default: 0.00
    end
  end
end
