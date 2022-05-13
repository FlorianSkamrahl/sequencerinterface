defmodule SequencerinterfaceWeb.SequencerLive.FormComponent do
  use SequencerinterfaceWeb, :live_component

  alias Sequencerinterface.Sequencers

  @impl true
  def update(%{sequencer: sequencer} = assigns, socket) do
    changeset = Sequencers.change_sequencer(sequencer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"sequencer" => sequencer_params}, socket) do
    changeset =
      socket.assigns.sequencer
      |> Sequencers.change_sequencer(sequencer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"sequencer" => sequencer_params}, socket) do
    save_sequencer(socket, socket.assigns.action, sequencer_params)
  end

  defp save_sequencer(socket, :edit, sequencer_params) do
    case Sequencers.update_sequencer(socket.assigns.sequencer, sequencer_params) do
      {:ok, _sequencer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sequencer updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_sequencer(socket, :new, sequencer_params) do
    case Sequencers.create_sequencer(sequencer_params) do
      {:ok, _sequencer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sequencer created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
