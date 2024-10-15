defmodule EcommerceWeb.ExclusiveDealLiveTest do
  use EcommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ecommerce.ProductsFixtures

  @create_attrs %{active: true, name: "some name", description: "some description", start_date: "2024-10-14T02:44:00", end_date: "2024-10-14T02:44:00", discount: "120.5"}
  @update_attrs %{active: false, name: "some updated name", description: "some updated description", start_date: "2024-10-15T02:44:00", end_date: "2024-10-15T02:44:00", discount: "456.7"}
  @invalid_attrs %{active: false, name: nil, description: nil, start_date: nil, end_date: nil, discount: nil}

  defp create_exclusive_deal(_) do
    exclusive_deal = exclusive_deal_fixture()
    %{exclusive_deal: exclusive_deal}
  end

  describe "Index" do
    setup [:create_exclusive_deal]

    test "lists all exclusive_deals", %{conn: conn, exclusive_deal: exclusive_deal} do
      {:ok, _index_live, html} = live(conn, ~p"/exclusive_deals")

      assert html =~ "Listing Exclusive deals"
      assert html =~ exclusive_deal.name
    end

    test "saves new exclusive_deal", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/exclusive_deals")

      assert index_live |> element("a", "New Exclusive deal") |> render_click() =~
               "New Exclusive deal"

      assert_patch(index_live, ~p"/exclusive_deals/new")

      assert index_live
             |> form("#exclusive_deal-form", exclusive_deal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#exclusive_deal-form", exclusive_deal: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/exclusive_deals")

      html = render(index_live)
      assert html =~ "Exclusive deal created successfully"
      assert html =~ "some name"
    end

    test "updates exclusive_deal in listing", %{conn: conn, exclusive_deal: exclusive_deal} do
      {:ok, index_live, _html} = live(conn, ~p"/exclusive_deals")

      assert index_live |> element("#exclusive_deals-#{exclusive_deal.id} a", "Edit") |> render_click() =~
               "Edit Exclusive deal"

      assert_patch(index_live, ~p"/exclusive_deals/#{exclusive_deal}/edit")

      assert index_live
             |> form("#exclusive_deal-form", exclusive_deal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#exclusive_deal-form", exclusive_deal: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/exclusive_deals")

      html = render(index_live)
      assert html =~ "Exclusive deal updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes exclusive_deal in listing", %{conn: conn, exclusive_deal: exclusive_deal} do
      {:ok, index_live, _html} = live(conn, ~p"/exclusive_deals")

      assert index_live |> element("#exclusive_deals-#{exclusive_deal.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#exclusive_deals-#{exclusive_deal.id}")
    end
  end

  describe "Show" do
    setup [:create_exclusive_deal]

    test "displays exclusive_deal", %{conn: conn, exclusive_deal: exclusive_deal} do
      {:ok, _show_live, html} = live(conn, ~p"/exclusive_deals/#{exclusive_deal}")

      assert html =~ "Show Exclusive deal"
      assert html =~ exclusive_deal.name
    end

    test "updates exclusive_deal within modal", %{conn: conn, exclusive_deal: exclusive_deal} do
      {:ok, show_live, _html} = live(conn, ~p"/exclusive_deals/#{exclusive_deal}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Exclusive deal"

      assert_patch(show_live, ~p"/exclusive_deals/#{exclusive_deal}/show/edit")

      assert show_live
             |> form("#exclusive_deal-form", exclusive_deal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#exclusive_deal-form", exclusive_deal: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/exclusive_deals/#{exclusive_deal}")

      html = render(show_live)
      assert html =~ "Exclusive deal updated successfully"
      assert html =~ "some updated name"
    end
  end
end
