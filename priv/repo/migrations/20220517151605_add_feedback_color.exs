defmodule Sequencerinterface.Repo.Migrations.AddFeedbackColor do
  use Ecto.Migration

  def change do
    alter table(:sequencerpad) do
      add :feedback_color, {:array, :integer}, default: [255,255,255]
    end

  end
end
