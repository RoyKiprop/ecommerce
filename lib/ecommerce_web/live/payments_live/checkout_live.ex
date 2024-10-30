defmodule EcommerceWeb.CheckoutLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.Cart
  alias Ecommerce.Mpesa
  alias Ecommerce.Payment

  def mount(_params, _session, socket) do
    cart_items = Cart.get_cart(socket.assigns.current_user.id).order_items
    cart = Cart.get_cart(socket.assigns.current_user.id)

    {:ok,
     assign(socket,
       cart_items: cart_items,
       cart: cart,
       form: to_form(%{}),
       selected_payment_method: nil,
       n: false,
       success_modal: false,
       error_msg: nil,
       success_msg: nil,
       error_modal: false
     )}
  end

  def handle_event("select_payment_method", %{"value" => method}, socket) do
    {:noreply, assign(socket, selected_payment_method: method)}
  end

  def handle_event("close_modal", _params, socket) do
    {:noreply, assign(socket, success_modal: false, error_modal: false)}
  end

  def handle_event("close-checkout", _params, socket) do
    {:noreply, push_navigate(socket, to: "/cart")}
  end

  def handle_event("submit_payment", %{"phone_number" => phone_number}, socket) do
    total_amount = 1

    formatted_phone =
      phone_number
      |> String.replace("+", "")

    case Mpesa.make_request(total_amount, formatted_phone, "reference", "Payment for Order Made") do
      {:ok, response_body} ->
        socket =
          assign(
            socket,
            formatted_phone: formatted_phone,
            total_amount: total_amount,
            checkoutId: response_body["CheckoutRequestID"]
          )

        check_payment_status(socket, false, "initiated")

      {:error, %HTTPoison.Error{reason: :timeout, id: nil}} ->
        {:noreply, put_flash(socket, :info, "Session timed out")}

      {:error, error} ->
        {:noreply, put_flash(socket, :info, "An error occurred #{error}")}

      _ ->
        {:noreply, socket}
    end
  end

  defp check_payment_status(socket, n, _string) when n == false do
    case Mpesa.make_query(socket.assigns.checkoutId) do
      {:ok, mpesa} ->
        handle_mpesa_response(socket, mpesa)

      {:error, _params} ->
        check_payment_status(socket, false, "Payment has started")
    end
  end

  defp check_payment_status(socket, n, string) when n == true do
    payment_changeset = %{
      user_id: socket.assigns.current_user.id,
      order_id: socket.assigns.cart.id,
      amount: socket.assigns.cart.total,
      payment_method: socket.assigns.selected_payment_method,
      status: "completed",
      currency: "KES",
      phone: socket.assigns.formatted_phone
    }

    case Payment.create_payment(payment_changeset) do
      {:ok, _payment} ->
        {:noreply, assign(socket, success_modal: true, success_msg: string)}

      {:error, _changeset} ->
        {:noreply, assign(socket, :error_modal, true)}
    end
  end

  defp check_payment_status(socket, "error", string) do
    payment_changeset = %{
      user_id: socket.assigns.current_user.id,
      order_id: socket.assigns.cart.id,
      amount: socket.assigns.cart.total,
      payment_method: socket.assigns.selected_payment_method,
      status: "failed",
      currency: "KES",
      phone: socket.assigns.formatted_phone
    }

    case Payment.create_payment(payment_changeset) do
      {:ok, _payment} ->
        {:noreply, assign(socket, error_modal: true, error_msg: string)}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  defp handle_mpesa_response(socket, mpesa) do
    case mpesa["ResultCode"] do
      "0" ->
        check_payment_status(socket, true, "Payment has been processed successfully")

      "1" ->
        check_payment_status(socket, "error", "Balance is insufficient")

      "17" ->
        check_payment_status(socket, "error", "Check if you entered details correctly")

      "26" ->
        check_payment_status(socket, "error", "System busy, Try again in a short while")

      "2001" ->
        check_payment_status(socket, "error", "Wrong Pin entered")

      "1001" ->
        check_payment_status(socket, "error", "Unable to lock subscriber")

      "1019" ->
        check_payment_status(socket, "error", "Transaction expired. No MO has been received")

      "9999" ->
        check_payment_status(socket, "error", "Request cancelled by user")

      "1032" ->
        check_payment_status(socket, "error", "Request cancelled by user")

      "1036" ->
        check_payment_status(socket, "error", "SMSC ACK timeout")

      "1037" ->
        check_payment_status(socket, "error", "Payment timeout")

      "SFC_IC0003" ->
        check_payment_status(socket, "error", "Payment timeout")

      _ ->
        {:noreply, put_flash(socket, :error, "Error processing payment")}
    end
  end
end
