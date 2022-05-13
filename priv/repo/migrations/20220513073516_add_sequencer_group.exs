defmodule Sequencerinterface.Repo.Migrations.AddSequencerGroup do
  use Ecto.Migration

  def change do
    alter table(:sequencerpad) do
      add :sequencergroup, :integer
    end

  end
end
