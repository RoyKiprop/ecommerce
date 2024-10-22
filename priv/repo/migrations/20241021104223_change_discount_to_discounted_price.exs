defmodule Ecommerce.Repo.Migrations.ChangeDiscountToDiscountedPrice do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :discounted_price, :decimal, precision: 10, scale: 2
    end

    execute "UPDATE products SET discounted_price = price * (1 - discount)"
  end
end
