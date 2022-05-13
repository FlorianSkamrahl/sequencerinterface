defmodule Sequencerinterface.Repo.Migrations.AddPositionList do
  use Ecto.Migration

  def change do
    alter table(:sequencerpad) do
      add :position, {:array, :integer}
    end

  end
end
