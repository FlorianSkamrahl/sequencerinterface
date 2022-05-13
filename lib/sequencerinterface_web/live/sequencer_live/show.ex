defmodule SequencerinterfaceWeb.SequencerLive.Show do
  use SequencerinterfaceWeb, :live_view

  alias Sequencerinterface.Sequencers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sequencer, Sequencers.get_sequencer!(id))}
  end

  defp page_title(:show), do: "Show Sequencer"
  defp page_title(:edit), do: "Edit Sequencer"
end
