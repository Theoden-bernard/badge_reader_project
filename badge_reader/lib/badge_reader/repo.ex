defmodule BadgeReader.Repo do
  use Ecto.Repo,
    otp_app: :badge_reader,
    adapter: Ecto.Adapters.Postgres
end
