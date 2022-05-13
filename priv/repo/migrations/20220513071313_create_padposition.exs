defmodule Sequencerinterface.Repo.Migrations.CreatePadposition do
  use Ecto.Migration

  def change do
    create table(:padposition) do
      add :x, :integer
      add :y, :integer
      add :pad_id, references(:sequencerpad, on_delete: :nothing)

      timestamps()
    end

    create index(:padposition, [:pad_id])
  end
end
