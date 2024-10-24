defmodule MyApp.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :amount, :decimal, null: false
      add :currency, :string, null: false, default: "KES"
      add :phone, :string
      add :payment_method, :string, null: false
      add :status, :string, null: false, default: "pending"
      add :order_id, references(:orders, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      add :transaction_id, :string

      timestamps()
    end

    # Indexes for faster lookups
    create index(:payments, [:order_id])
    create index(:payments, [:user_id])
  end
end
