defmodule Sequencerinterface.Repo.Migrations.CreateSequencerpad do
  use Ecto.Migration

  def change do
    create table(:sequencerpad) do
      add :color, :integer
      add :velocity, :integer
      add :scale, :integer
      add :padid, :integer

      timestamps()
    end
  end
end
