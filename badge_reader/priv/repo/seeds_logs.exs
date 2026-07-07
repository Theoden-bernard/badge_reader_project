# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BadgeReader.Repo.insert!(%BadgeReader.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BadgeReader.Repo
alias BadgeReader.{Accounts, AccessPointsManager}
alias BadgeReader.Logs.Log
# ==========================================
# STEPS 1 : Cleanup logs
# ==========================================
IO.puts("Nettoyage des logs")
Repo.delete_all(Log)

# ==========================================
# STEPS 2 : Creation fictif logs
# ==========================================
users_with_badges =
  Accounts.get_all_user()
  |> Repo.preload(:badge)
  |> Enum.filter(fn u -> u.badge != nil end)

pointeuse =
  AccessPointsManager.get_access_points_by_name("Pointeuse")

week = Enum.map(0..6, fn n -> Date.add(Date.utc_today(), -n) end)

Enum.each(week, fn day ->
  count = Enum.random((2..Accounts.count_all_user()))

  daily_users = Enum.take_random(users_with_badges, count)

  Enum.each(daily_users, fn user ->
    %Log{}
    |> Log.changeset_logs(%{type: :in, clocked_at: DateTime.new!(day, Time.new!(Enum.random(8..10), 0, 0), "Etc/UTC"), badge_id: user.badge.id, access_point_id: pointeuse.id})
    |> Repo.insert!()

    if (day != Date.utc_today()) do
      %Log{}
      |> Log.changeset_logs(%{type: :out, clocked_at: DateTime.new!(day, Time.new!(Enum.random(15..18), 0, 0), "Etc/UTC"), badge_id: user.badge.id, access_point_id: pointeuse.id})
      |> Repo.insert!()
    end
  end)
end)

IO.puts("Logs crée !")
