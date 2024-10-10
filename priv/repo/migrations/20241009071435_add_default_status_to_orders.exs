defmodule YourApp.Repo.Migrations.AddDefaultStatusToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      modify :status, :string, default: "cart"
    end
  end
end
