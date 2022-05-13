defmodule Sequencerinterface.Sequencers.Padposition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "padposition" do
    field :x, :integer
    field :y, :integer
    field :pad_id, :id

    timestamps()
  end

  @doc false
  def changeset(sequencers, attrs) do
    sequencers
    |> cast(attrs, [:x, :y])
    |> validate_required([:x, :y])
  end
end
