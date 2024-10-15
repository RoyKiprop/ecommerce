defmodule Ecommerce.ProductsTest do
  use Ecommerce.DataCase

  alias Ecommerce.Products

  describe "products" do
    alias Ecommerce.Products.Product

    import Ecommerce.ProductsFixtures

    @invalid_attrs %{name: nil, description: nil, image: nil, currency: nil, color: nil, price: nil, stock: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", description: "some description", image: "some image", currency: "some currency", color: "some color", price: "120.5", stock: 42}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.image == "some image"
      assert product.currency == "some currency"
      assert product.color == "some color"
      assert product.price == Decimal.new("120.5")
      assert product.stock == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", image: "some updated image", currency: "some updated currency", color: "some updated color", price: "456.7", stock: 43}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.image == "some updated image"
      assert product.currency == "some updated currency"
      assert product.color == "some updated color"
      assert product.price == Decimal.new("456.7")
      assert product.stock == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end

  describe "categories" do
    alias Ecommerce.Products.Category

    import Ecommerce.ProductsFixtures

    @invalid_attrs %{name: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Products.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Products.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Category{} = category} = Products.create_category(valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Category{} = category} = Products.update_category(category, update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_category(category, @invalid_attrs)
      assert category == Products.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Products.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Products.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Products.change_category(category)
    end
  end

  describe "exclusive_deals" do
    alias Ecommerce.Products.ExclusiveDeal

    import Ecommerce.ProductsFixtures

    @invalid_attrs %{active: nil, name: nil, description: nil, start_date: nil, end_date: nil, discount: nil}

    test "list_exclusive_deals/0 returns all exclusive_deals" do
      exclusive_deal = exclusive_deal_fixture()
      assert Products.list_exclusive_deals() == [exclusive_deal]
    end

    test "get_exclusive_deal!/1 returns the exclusive_deal with given id" do
      exclusive_deal = exclusive_deal_fixture()
      assert Products.get_exclusive_deal!(exclusive_deal.id) == exclusive_deal
    end

    test "create_exclusive_deal/1 with valid data creates a exclusive_deal" do
      valid_attrs = %{active: true, name: "some name", description: "some description", start_date: ~N[2024-10-14 02:37:00], end_date: ~N[2024-10-14 02:37:00], discount: "120.5"}

      assert {:ok, %ExclusiveDeal{} = exclusive_deal} = Products.create_exclusive_deal(valid_attrs)
      assert exclusive_deal.active == true
      assert exclusive_deal.name == "some name"
      assert exclusive_deal.description == "some description"
      assert exclusive_deal.start_date == ~N[2024-10-14 02:37:00]
      assert exclusive_deal.end_date == ~N[2024-10-14 02:37:00]
      assert exclusive_deal.discount == Decimal.new("120.5")
    end

    test "create_exclusive_deal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_exclusive_deal(@invalid_attrs)
    end

    test "update_exclusive_deal/2 with valid data updates the exclusive_deal" do
      exclusive_deal = exclusive_deal_fixture()
      update_attrs = %{active: false, name: "some updated name", description: "some updated description", start_date: ~N[2024-10-15 02:37:00], end_date: ~N[2024-10-15 02:37:00], discount: "456.7"}

      assert {:ok, %ExclusiveDeal{} = exclusive_deal} = Products.update_exclusive_deal(exclusive_deal, update_attrs)
      assert exclusive_deal.active == false
      assert exclusive_deal.name == "some updated name"
      assert exclusive_deal.description == "some updated description"
      assert exclusive_deal.start_date == ~N[2024-10-15 02:37:00]
      assert exclusive_deal.end_date == ~N[2024-10-15 02:37:00]
      assert exclusive_deal.discount == Decimal.new("456.7")
    end

    test "update_exclusive_deal/2 with invalid data returns error changeset" do
      exclusive_deal = exclusive_deal_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_exclusive_deal(exclusive_deal, @invalid_attrs)
      assert exclusive_deal == Products.get_exclusive_deal!(exclusive_deal.id)
    end

    test "delete_exclusive_deal/1 deletes the exclusive_deal" do
      exclusive_deal = exclusive_deal_fixture()
      assert {:ok, %ExclusiveDeal{}} = Products.delete_exclusive_deal(exclusive_deal)
      assert_raise Ecto.NoResultsError, fn -> Products.get_exclusive_deal!(exclusive_deal.id) end
    end

    test "change_exclusive_deal/1 returns a exclusive_deal changeset" do
      exclusive_deal = exclusive_deal_fixture()
      assert %Ecto.Changeset{} = Products.change_exclusive_deal(exclusive_deal)
    end
  end

  describe "exclusive_deals" do
    alias Ecommerce.Products.ExclusiveDeal

    import Ecommerce.ProductsFixtures

    @invalid_attrs %{active: nil, name: nil, description: nil, start_date: nil, end_date: nil, discount: nil}

    test "list_exclusive_deals/0 returns all exclusive_deals" do
      exclusive_deal = exclusive_deal_fixture()
      assert Products.list_exclusive_deals() == [exclusive_deal]
    end

    test "get_exclusive_deal!/1 returns the exclusive_deal with given id" do
      exclusive_deal = exclusive_deal_fixture()
      assert Products.get_exclusive_deal!(exclusive_deal.id) == exclusive_deal
    end

    test "create_exclusive_deal/1 with valid data creates a exclusive_deal" do
      valid_attrs = %{active: true, name: "some name", description: "some description", start_date: ~N[2024-10-14 02:44:00], end_date: ~N[2024-10-14 02:44:00], discount: "120.5"}

      assert {:ok, %ExclusiveDeal{} = exclusive_deal} = Products.create_exclusive_deal(valid_attrs)
      assert exclusive_deal.active == true
      assert exclusive_deal.name == "some name"
      assert exclusive_deal.description == "some description"
      assert exclusive_deal.start_date == ~N[2024-10-14 02:44:00]
      assert exclusive_deal.end_date == ~N[2024-10-14 02:44:00]
      assert exclusive_deal.discount == Decimal.new("120.5")
    end

    test "create_exclusive_deal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_exclusive_deal(@invalid_attrs)
    end

    test "update_exclusive_deal/2 with valid data updates the exclusive_deal" do
      exclusive_deal = exclusive_deal_fixture()
      update_attrs = %{active: false, name: "some updated name", description: "some updated description", start_date: ~N[2024-10-15 02:44:00], end_date: ~N[2024-10-15 02:44:00], discount: "456.7"}

      assert {:ok, %ExclusiveDeal{} = exclusive_deal} = Products.update_exclusive_deal(exclusive_deal, update_attrs)
      assert exclusive_deal.active == false
      assert exclusive_deal.name == "some updated name"
      assert exclusive_deal.description == "some updated description"
      assert exclusive_deal.start_date == ~N[2024-10-15 02:44:00]
      assert exclusive_deal.end_date == ~N[2024-10-15 02:44:00]
      assert exclusive_deal.discount == Decimal.new("456.7")
    end

    test "update_exclusive_deal/2 with invalid data returns error changeset" do
      exclusive_deal = exclusive_deal_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_exclusive_deal(exclusive_deal, @invalid_attrs)
      assert exclusive_deal == Products.get_exclusive_deal!(exclusive_deal.id)
    end

    test "delete_exclusive_deal/1 deletes the exclusive_deal" do
      exclusive_deal = exclusive_deal_fixture()
      assert {:ok, %ExclusiveDeal{}} = Products.delete_exclusive_deal(exclusive_deal)
      assert_raise Ecto.NoResultsError, fn -> Products.get_exclusive_deal!(exclusive_deal.id) end
    end

    test "change_exclusive_deal/1 returns a exclusive_deal changeset" do
      exclusive_deal = exclusive_deal_fixture()
      assert %Ecto.Changeset{} = Products.change_exclusive_deal(exclusive_deal)
    end
  end
end
