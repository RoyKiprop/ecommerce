defmodule Ecommerce.Order_ItemsTest do
  use Ecommerce.DataCase

  alias Ecommerce.Order_Items

  describe "order_items" do
    alias Ecommerce.Order_Items.Order_Item

    import Ecommerce.Order_ItemsFixtures

    @invalid_attrs %{quantity: nil, price: nil, currecny: nil}

    test "list_order_items/0 returns all order_items" do
      order__item = order__item_fixture()
      assert Order_Items.list_order_items() == [order__item]
    end

    test "get_order__item!/1 returns the order__item with given id" do
      order__item = order__item_fixture()
      assert Order_Items.get_order__item!(order__item.id) == order__item
    end

    test "create_order__item/1 with valid data creates a order__item" do
      valid_attrs = %{quantity: 42, price: "120.5", currecny: "some currecny"}

      assert {:ok, %Order_Item{} = order__item} = Order_Items.create_order__item(valid_attrs)
      assert order__item.quantity == 42
      assert order__item.price == Decimal.new("120.5")
      assert order__item.currecny == "some currecny"
    end

    test "create_order__item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Order_Items.create_order__item(@invalid_attrs)
    end

    test "update_order__item/2 with valid data updates the order__item" do
      order__item = order__item_fixture()
      update_attrs = %{quantity: 43, price: "456.7", currecny: "some updated currecny"}

      assert {:ok, %Order_Item{} = order__item} = Order_Items.update_order__item(order__item, update_attrs)
      assert order__item.quantity == 43
      assert order__item.price == Decimal.new("456.7")
      assert order__item.currecny == "some updated currecny"
    end

    test "update_order__item/2 with invalid data returns error changeset" do
      order__item = order__item_fixture()
      assert {:error, %Ecto.Changeset{}} = Order_Items.update_order__item(order__item, @invalid_attrs)
      assert order__item == Order_Items.get_order__item!(order__item.id)
    end

    test "delete_order__item/1 deletes the order__item" do
      order__item = order__item_fixture()
      assert {:ok, %Order_Item{}} = Order_Items.delete_order__item(order__item)
      assert_raise Ecto.NoResultsError, fn -> Order_Items.get_order__item!(order__item.id) end
    end

    test "change_order__item/1 returns a order__item changeset" do
      order__item = order__item_fixture()
      assert %Ecto.Changeset{} = Order_Items.change_order__item(order__item)
    end
  end
end
