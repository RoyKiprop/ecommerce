defmodule EcommerceWeb.ExclusiveDealLive.FormComponent do
  use EcommerceWeb, :live_component

  alias Ecommerce.Products

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage exclusive_deal records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="exclusive_deal-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:start_date]} type="datetime-local" label="Start date" />
        <.input field={@form[:end_date]} type="datetime-local" label="End date" />
        <.input field={@form[:discount]} type="number" label="Discount" step="any" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input
          field={@form[:product_id]}
          type="select"
          label="Product"
          options={Enum.map(@products, &{&1.name, &1.id})}
        />

        <:actions>
          <.button phx-disable-with="Saving...">Save Exclusive deal</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{exclusive_deal: exclusive_deal} = assigns, socket) do
    # Load the list of products
    # You need to define this function to return all products
    products = Products.list_products()

    {:ok,
     socket
     |> assign(assigns)
     # Assign products to the socket
     |> assign(products: products)
     |> assign_new(:form, fn ->
       to_form(Products.change_exclusive_deal(exclusive_deal))
     end)}
  end

  @impl true
  def handle_event("validate", %{"exclusive_deal" => exclusive_deal_params}, socket) do
    changeset =
      Products.change_exclusive_deal(socket.assigns.exclusive_deal, exclusive_deal_params)

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"exclusive_deal" => exclusive_deal_params}, socket) do
    save_exclusive_deal(socket, socket.assigns.action, exclusive_deal_params)
  end

  defp save_exclusive_deal(socket, :edit, exclusive_deal_params) do
    case Products.update_exclusive_deal(socket.assigns.exclusive_deal, exclusive_deal_params) do
      {:ok, exclusive_deal} ->
        notify_parent({:saved, exclusive_deal})

        {:noreply,
         socket
         |> put_flash(:info, "Exclusive deal updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_exclusive_deal(socket, :new, exclusive_deal_params) do
    case Products.create_exclusive_deal(exclusive_deal_params) do
      {:ok, exclusive_deal} ->
        notify_parent({:saved, exclusive_deal})

        {:noreply,
         socket
         |> put_flash(:info, "Exclusive deal created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
