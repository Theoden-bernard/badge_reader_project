ExUnit.start(
  exclude: [e2e: true]
)

{:ok, _} = Application.ensure_all_started(:badge_reader)
if System.get_env("CI") != "true" do
  {:ok, _} = Application.ensure_all_started(:wallaby)
end

Ecto.Adapters.SQL.Sandbox.mode(BadgeReader.Repo, :manual)
