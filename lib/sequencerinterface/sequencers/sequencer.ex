defmodule Sequencerinterface.Sequencers.Sequencer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sequencerpad" do
    field :color, :integer
    field :padid, :integer
    field :scale, :integer
    field :velocity, :integer
    field :sequencergroup, :integer
    field :feedback_color, :integer

    field :position , {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(sequencer, attrs) do
    sequencer
    |> cast(attrs, [:color, :velocity, :scale, :padid, :sequencergroup, :position, :feedback_color])
    |> validate_required([:color, :velocity, :scale, :padid, :sequencergroup, :position, :feedback_color])
  end
end
