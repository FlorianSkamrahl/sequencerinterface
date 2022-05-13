defmodule Sequencerinterface.SequencersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sequencerinterface.Sequencers` context.
  """

  @doc """
  Generate a sequencer.
  """
  def sequencer_fixture(attrs \\ %{}) do
    {:ok, sequencer} =
      attrs
      |> Enum.into(%{
        color: 42,
        padid: 42,
        scale: 42,
        velocity: 42
      })
      |> Sequencerinterface.Sequencers.create_sequencer()

    sequencer
  end
end
