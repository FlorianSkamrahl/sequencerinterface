defmodule SequencerinterfaceWeb.SequencerLive.Index do
  use SequencerinterfaceWeb, :live_view

  alias Sequencerinterface.Sequencers
  alias Sequencerinterface.Sequencers.Sequencer

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Sequencers.subscribe()
    {:ok, assign(socket, :sequencerpad, list_sequencerpad()), temporary_assigns: [sequencerpad: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sequencer")
    |> assign(:sequencer, Sequencers.get_sequencer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sequencer")
    |> assign(:sequencer, %Sequencer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sequencerpad")
    |> assign(:sequencer, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sequencer = Sequencers.get_sequencer!(id)
    {:ok, _} = Sequencers.delete_sequencer(sequencer)

    {:noreply, assign(socket, :sequencerpad, list_sequencerpad())}
  end

  def handle_event("clear", _value, socket) do
    {_, all_pads} = Sequencers.clear_sequencerpad_group(0)
    SequencerinterfaceWeb.Endpoint.broadcast!("sequencer:lobby", "clear", %{})
    #{:noreply, update(socket, :sequencerpad, all_pads)}
    {:noreply, socket}
  end

  def handle_event("calibrate", _value, socket) do
    #list all routes mix phx.routes
    SequencerinterfaceWeb.Endpoint.broadcast!("sequencer:lobby", "calibrate", %{})
    {:noreply, socket}
  end

  #Invoked to handle messages from other Elixir processes. -> this time from the sequencerchannel
  def handle_info(%Phoenix.Socket.Broadcast{event: "python_response", payload: %{message: msg}}, socket) do
    #list all routes mix phx.routes
    Process.send_after(self(), :clear_flash, 3000)
    {:noreply, socket
    |> put_flash(:info, msg)}
  end

  def handle_info(:clear_flash, socket) do
    {:noreply, clear_flash(socket)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{event: "sequencer_feedback", payload: %{"color" => color, "padid" => padid, "position" => [y, x]}}, socket) do
    #IO.puts(color)
    #IO.puts(padid)
    #IO.puts("[#{y}, #{x}]")
    {:ok, color} = Sequencers.toggle_feedback_color(padid, color)
    {:noreply, assign(socket, :color, color)}
    #list all routes mix phx.routes
    #{:noreply, socket
    #|> put_flash(:info, msg)}
    #{:noreply, socket}
  end



  #handle PubSub event updated_sequencerpad
  def handle_info({:updated_sequencerpad, updatedsequencerpad}, socket) do
    {:noreply, update(socket, :sequencerpad, fn sequencerpad -> [updatedsequencerpad | sequencerpad] end)}
  end

  def handle_info({:clear_sequencerpad, sequencerpads_list}, socket) do
    {:noreply, assign(socket, :sequencerpad, sequencerpads_list)}
  end




  defp list_sequencerpad do
    Sequencers.list_sequencerpad()
  end
end
