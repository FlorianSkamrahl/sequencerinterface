defmodule Sequencerinterface.Repo do
  use Ecto.Repo,
    otp_app: :sequencerinterface,
    adapter: Ecto.Adapters.Postgres
end
