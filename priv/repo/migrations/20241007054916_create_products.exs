defmodule Ecommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :text
      add :price, :decimal
      add :currency, :string
      add :color, :string
      add :image, :string
      add :stock, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
