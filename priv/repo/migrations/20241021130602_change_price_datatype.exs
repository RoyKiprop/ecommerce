defmodule Ecommerce.Repo.Migrations.ChangePriceDatatype do
  use Ecto.Migration

  def change do
    alter table(:products) do
      modify :price, :decimal, precision: 10, scale: 2
    end
  end
end
