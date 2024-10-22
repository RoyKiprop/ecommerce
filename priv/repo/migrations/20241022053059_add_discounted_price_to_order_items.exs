defmodule Ecommerce.Repo.Migrations.AddDiscountedPriceToOrderItems do
  use Ecto.Migration

  def change do
    alter table(:order_items) do
      add :discounted_price, :decimal, precision: 10, scale: 2
    end
  end
end
