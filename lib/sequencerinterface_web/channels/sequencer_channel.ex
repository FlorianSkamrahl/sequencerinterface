defmodule SequencerinterfaceWeb.SequencerChannel do
  use SequencerinterfaceWeb, :channel

  @impl true
  def join("sequencer:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (sequencer:lobby).
  @impl true
  def handle_in("shout", %{"msg" => msg}, socket) do
    #IO.puts(msg)
    #Phoenix.PubSub.broadcast(Sequencerinterface.PubSub, "sequencers", {"python_response", msg})
    #SequencerinterfaceWeb.Endpoint.broadcast!("sequencer:lobby", "calibrate", %{})
    #SequencerinterfaceWeb.Endpoint.broadcast!(Sequencerinterface.PubSub  , "sequencers", {"pythonresponse", msg})
    SequencerinterfaceWeb.Endpoint.broadcast("sequencers", "python_response", %{message: msg})


    #SequencerinterfaceWeb.Endpoint.broadcast!(Sequencerinterface.PubSub, "sequencers", {:pythonresponse, %{"msg" => msg}})



    #broadcast(socket, "shout", msg)
    {:noreply, socket}
  end

  def handle_in("sequencer_feedback", payload, socket) do
    #broadcast payload to liveView
    SequencerinterfaceWeb.Endpoint.broadcast("sequencers", "sequencer_feedback", payload)
    {:noreply, socket}
  end

  def handle_in("updated_sequencerpad", %{"color" => color, "position" => position, "padid" => padid}, socket) do
    broadcast!(socket, "updated_sequencerpad", %{position: position, color: color, padid: padid})
    {:noreply, socket}
  end

  def handle_in("clear", %{}, socket) do
    broadcast!(socket, "clear", %{})
    {:noreply, socket}
  end

  def handle_in("calibrate", %{}, socket) do
    broadcast!(socket, "calibrate", %{})
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
