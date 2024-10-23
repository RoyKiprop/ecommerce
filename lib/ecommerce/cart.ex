defmodule Ecommerce.Cart do
  alias Ecommerce.Repo
  alias Ecommerce.{Orders.Order, Order_Items.Order_Item}
  alias Ecommerce.Products.Product
  import Ecto.Query

  @discount_threshold 100_000
  @discount_value 5000

  def get_cart(user_id) do
    case Repo.one(
           from o in Order,
             where: o.user_id == ^user_id and o.status == "cart",
             preload: [order_items: :product]
         ) do
      nil -> create_cart(user_id)
      cart -> cart
    end
  end

  def create_cart(user_id) do
    %Order{}
    |> Order.changeset(%{user_id: user_id, status: "cart"})
    |> Repo.insert!()
    |> Repo.preload(:order_items)
  end

  def add_item_to_cart(user_id, product_id) do
    cart = get_cart(user_id)

    case Repo.get(Product, product_id) do
      nil ->
        {:error, "Product not found"}

      product ->
        case Enum.find(cart.order_items, &(&1.product_id == product.id)) do
          nil ->
            # Safely handle discounted_price
            discounted_price = product.discounted_price || 0

            order_item_changeset =
              %Order_Item{}
              |> Order_Item.changeset(%{
                product_id: product.id,
                quantity: 1,
                price: product.price,
                discounted_price: discounted_price,
                currency: product.currency,
                order_id: cart.id
              })

            case Repo.insert(order_item_changeset) do
              {:ok, _order_item} ->
                # Recalculate the cart subtotal and apply discount if applicable
                cart_subtotal(user_id)

                {:ok, "Item added successfully"}

              {:error, _changeset} ->
                {:error, "Failed to add item to cart"}
            end

          _existing_item ->
            {:error, "Item already in cart"}
        end
    end
  end

  def count_cart_items(user_id) do
    cart = get_cart(user_id)
    length(cart.order_items)
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

  def change_quantity(product_id, user_id, new_quantity) do
    cart = get_cart(user_id)

    case Repo.get_by(Order_Item, order_id: cart.id, product_id: product_id) do
      nil ->
        {:error, "Item not found in the cart"}

      order_item ->
        product = Repo.get!(Product, product_id)

        # Convert to Decimal before multiplication
        new_price = Decimal.mult(Decimal.new(product.price), Decimal.new(new_quantity))

        new_discount =
          if product.discounted_price do
            Decimal.mult(Decimal.new(product.discounted_price), Decimal.new(new_quantity))
          else
            nil
          end

        changeset =
          Order_Item.changeset(order_item, %{
            quantity: new_quantity,
            price: new_price,
            discounted_price: new_discount
          })

        case Repo.update(changeset) do
          {:ok, updated_item} ->
            {:ok, "Item updated successfully"}

          {:error, changeset} ->
            {:error, "Failed to update quantity: #{inspect(changeset.errors)}"}
        end
    end
  end

  def item_in_cart?(user_id, product_id) do
    cart = get_cart(user_id)
    Enum.any?(cart.order_items, fn item -> item.product_id == String.to_integer(product_id) end)
  end

  def cart_subtotal(user_id) do
    cart = get_cart(user_id)

    # Initialize accumulator as a Decimal
    sub_total =
      Enum.reduce(cart.order_items, Decimal.new(0), fn item, acc ->
        # Ensure we are adding two Decimal values
        acc |> Decimal.add(item.discounted_price || Decimal.new(0))
      end)

    # Create the changeset
    changeset = Order.changeset(cart, %{sub_total: sub_total})

    # Update the order and handle the result
    case Repo.update(changeset) do
      {:ok, _order} ->
        # Return the subtotal if needed
        {:ok, sub_total}

      {:error, changeset} ->
        {:error, "Failed to update subtotal: #{inspect(changeset.errors)}"}
    end
  end

  def get_cart_subtotal(user_id) do
    cart = get_cart(user_id)

    cart.sub_total
  end

  def get_item(user_id, product_id) do
    cart = get_cart(user_id)
    Enum.find(cart.order_items, fn item -> item.product_id == product_id end)
  end
end
