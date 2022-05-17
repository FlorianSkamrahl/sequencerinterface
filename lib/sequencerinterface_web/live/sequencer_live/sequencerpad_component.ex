defmodule SequencerinterfaceWeb.SequencerLive.SequencerpadComponent do
  use SequencerinterfaceWeb, :live_component
  alias Sequencerinterface.Sequencers

  def render(assigns) do
    #{if @todo.__meta__.state == :deleted do hidden end}
    ~H"""
    <div id={"pad-#{@sequencer.id}"} class={"w-full border-stone-300 border-2 rounded shadow-lg hover:shadow-2xl hover:cursor-pointer #{if @sequencer.feedback_color == 0 do "bg-blue-200" end} #{if @sequencer.feedback_color == 1 do "bg-red-200" end} #{if @sequencer.feedback_color == 2 do "bg-green-200" end} #{if @sequencer.feedback_color == 3 do "bg-yellow-200" end}"}>
    <div class="flex justify-center py-4">
      <div>
        <div class="text-center">
          <%= @sequencer.padid %>
        </div>
        <div class="flex justify-center gap-2">
          <div class="form-check">
            <%= checkbox(:sequencer, :color, phx_click: "toggle_color", phx_target: @myself, phx_value_color: 0, phx_value_padid: @sequencer.padid, value: @sequencer.color == 0, class: "form-check-input appearance-none h-6 w-6 border border-gray-300 rounded-sm bg-white hover:bg-blue-600 checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 my-1 align-top bg-no-repeat bg-center bg-contain float-left cursor-pointer") %>
          </div>
          <div class="form-check">
            <%= checkbox(:sequencer, :color, phx_click: "toggle_color", phx_target: @myself, phx_value_color: 1, phx_value_padid: @sequencer.padid, value: @sequencer.color == 1, class: "form-check-input appearance-none h-6 w-6 border border-gray-300 rounded-sm bg-white hover:bg-red-600 checked:bg-red-600 checked:border-red-600 focus:outline-none transition duration-200 my-1 align-top bg-no-repeat bg-center bg-contain float-left cursor-pointer") %>
          </div>
          <div class="form-check">
            <%= checkbox(:sequencer, :color, phx_click: "toggle_color", phx_target: @myself, phx_value_color: 2, phx_value_padid: @sequencer.padid, value: @sequencer.color == 2, class: "form-check-input appearance-none h-6 w-6 border border-gray-300 rounded-sm bg-white hover:bg-green-600 checked:bg-green-600 checked:border-green-600 focus:outline-none transition duration-200 my-1 align-top bg-no-repeat bg-center bg-contain float-left cursor-pointer") %>
          </div>
          <div class="form-check">
            <%= checkbox(:sequencer, :color, phx_click: "toggle_color", phx_target: @myself, phx_value_color: 3, phx_value_padid: @sequencer.padid, value: @sequencer.color == 3, class: "form-check-input appearance-none h-6 w-6 border border-gray-300 rounded-sm bg-white hover:bg-yellow-600 checked:bg-yellow-600 checked:border-yellow-600 focus:outline-none transition duration-200 my-1 align-top bg-no-repeat bg-center bg-contain float-left cursor-pointer") %>
          </div>
        </div>
      </div>
    </div>
    </div>
    """
  end

  def handle_event("toggle_color", %{"color" => color, "padid" => padid, "value" => value}, socket) do
    #event is handeled here so dont forget to set the phx-target={@myself}
    {:ok, color} = Sequencers.toggle_color(padid, color)
    {:noreply, assign(socket, :color, color)}

end

def handle_event("toggle_color", %{"color" => color, "padid" => padid}, socket) do
  #event is handeled here so dont forget to set the phx-target={@myself}

  #if value is unchecked no value attribute is passed -> clear with color set to -1
  {:ok, color} = Sequencers.toggle_color(padid, -1)
  {:noreply, assign(socket, :color, color)}

end


end
