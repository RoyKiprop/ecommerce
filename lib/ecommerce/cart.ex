defmodule Ecommerce.Cart do
  import Ecto.Query
  alias Ecommerce.Repo
  alias Ecommerce.{Orders.Order, Order_Items.Order_Item}
  alias Ecommerce.Products.Product

  def get_cart(user_id) do
    case Repo.get_by(Order, user_id: user_id, status: "cart") do
      nil ->
        create_cart(user_id)

      order ->
        _order_with_items = Repo.preload(order, order_items: :product)
    end
  end

  def create_cart(user_id) do
    %Order{}
    |> Order.changeset(%{user_id: user_id, status: "cart"})
    |> Repo.insert!()
  end

  def add_item_to_cart(user_id, product_id) do
    cart = get_cart(user_id)

    case Repo.get(Product, product_id) do
      nil ->
        {:error, "Product not found"}

      product ->
        case Repo.get_by(Order_Item, order_id: cart.id, product_id: product_id) do
          nil ->
            changeset =
              %Order_Item{}
              |> Order_Item.changeset(%{
                product_id: product.id,
                quantity: 1,
                price: product.price,
                discount: product.discount,
                order_id: cart.id
              })

            case Repo.insert(changeset) do
              {:ok, _order_item} ->
                {:ok, "Item created successfully"}

              {:error, changeset} ->
                IO.inspect(changeset.errors, label: "Failed to insert Order_Item")
                {:error, "Failed to add item to cart"}
            end

          _order_item ->
            {:error, "Item already in cart"}
        end
    end
  end

  def count_cart_items(user_id) do
    # Get the user's cart
    cart = get_cart(user_id)

    # Query the number of items in the cart
    Repo.aggregate(
      from(oi in Order_Item, where: oi.order_id == ^cart.id),
      :count,
      :id
    )
  end

  def delete_cart_item(product_id, user_id) do
    cart = get_cart(user_id)

    case Repo.get_by(Order_Item, order_id: cart.id, product_id: product_id) do
      nil ->
        {:error, "Item not found in the cart"}

      order_item ->
        case Repo.delete(order_item) do
          {:ok, _} ->
            {:ok, "Item deleted successfully"}

          {:error, reason} ->
            {:error, "Failed to delete item: #{reason}"}
        end
    end
  end

  def change_quantity(product_id, user_id, quantity) do
    cart = get_cart(user_id)

    case Repo.get_by(Order_Item, order_id: cart.id, product_id: product_id) do
      nil ->
        {:error, "Item not found in the cart"}

      order_item ->
        product = Repo.get!(Product, product_id)
        new_price = Decimal.mult(product.price, Decimal.new(quantity))

        changeset =
          Order_Item.changeset(order_item, %{
            quantity: quantity,
            price: new_price
          })

        case Repo.update(changeset) do
          {:ok, _} ->
            {:ok, "Item updated successfully"}

          {:error, reason} ->
            {:error, "Failed to update quantity and price: #{reason}"}
        end
    end
  end
end
