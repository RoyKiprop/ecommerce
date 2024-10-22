defmodule Ecommerce.Repo.Migrations.UpdateDiscountedPriceCalculation do
  use Ecto.Migration

  def change do
    execute "UPDATE products SET discounted_price = price - discount"
  end
end
