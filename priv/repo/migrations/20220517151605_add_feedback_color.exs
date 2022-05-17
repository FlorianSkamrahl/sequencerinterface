defmodule Sequencerinterface.Repo.Migrations.AddFeedbackColor do
  use Ecto.Migration

  def change do
    alter table(:sequencerpad) do
      add :feedback_color, :integer
    end

  end
end
