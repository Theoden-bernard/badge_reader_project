ExUnit.start(
  exclude: [e2e: true]
)

{:ok, _} = Application.ensure_all_started(:badge_reader)
{:ok, _} = Application.ensure_all_started(:wallaby)

Ecto.Adapters.SQL.Sandbox.mode(BadgeReader.Repo, :manual)
