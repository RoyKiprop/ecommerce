defmodule Ecommerce.OrdersTest do
  use Ecommerce.DataCase

  alias Ecommerce.Orders

  describe "orders" do
    alias Ecommerce.Orders.Order

    import Ecommerce.OrdersFixtures

    @invalid_attrs %{status: nil, total: nil, sub_total: nil, discount: nil, tax: nil, shipping: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{status: "some status", total: "120.5", sub_total: "120.5", discount: "120.5", tax: "120.5", shipping: "120.5"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.status == "some status"
      assert order.total == Decimal.new("120.5")
      assert order.sub_total == Decimal.new("120.5")
      assert order.discount == Decimal.new("120.5")
      assert order.tax == Decimal.new("120.5")
      assert order.shipping == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{status: "some updated status", total: "456.7", sub_total: "456.7", discount: "456.7", tax: "456.7", shipping: "456.7"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.status == "some updated status"
      assert order.total == Decimal.new("456.7")
      assert order.sub_total == Decimal.new("456.7")
      assert order.discount == Decimal.new("456.7")
      assert order.tax == Decimal.new("456.7")
      assert order.shipping == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
