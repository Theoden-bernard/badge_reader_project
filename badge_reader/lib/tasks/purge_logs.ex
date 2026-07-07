defmodule Mix.Tasks.PurgeLogs do
  @moduledoc "When call this module zill delete all badge entry logs older thant 6 months"
  use Mix.Task

  alias BadgeReader.Logs

  def run(_) do
    Ecto.Migrator.with_repo(BadgeReader.Repo, &purge_logs(&1))
  end

  defp purge_logs(_) do
    date =
      DateTime.utc_now()
      |> DateTime.add(-180, :day)

      Logs.list_logs()
      |> Enum.filter(fn log ->
        DateTime.before?(log.clocked_at, date)
      end)
      |> Enum.map(&Logs.delete_log(&1))
  end
end
