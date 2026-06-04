defmodule BadgeReader.AccessPointsManager do
  alias BadgeReader.AccessPointsManager.AccessPoints
  alias BadgeReader.Repo
  alias BadgeReader.RoleManager.Role
  alias BadgeReader.BadgeManager
  alias BadgeReader.BadgeManager.Badge
  alias BadgeReader.Logs.Log
  alias BadgeReader.Logs

  import Ecto.Query

  def create_access_point(attrs, role_ids) do
    roles = Repo.all(from r in Role, where: r.id in ^role_ids)

    %AccessPoints{}
    |> AccessPoints.changeset_access_points(attrs, roles)
    |> Repo.insert()
  end

  def edit_access_point(name_access_point, attrs) do

    case Repo.update(Ecto.Changeset.change(get_access_points_by_name(name_access_point), attrs))  do
      {:ok, _struct} -> IO.inspect("acesse_point update")
      {:error, _changeset} -> IO.inspect("access_point error update")

    end
  end

  def list_access_points() do
    AccessPoints
    |> Repo.all()
    |> Repo.preload([:roles])
  end

  def get_access_points_by_name(name) do
    AccessPoints
    |> where(nom_access_points: ^name)
    |> Repo.one()
    |> Repo.preload([:roles])
  end

  @doc """
  compare_role(%Badge{} = badge, access_point = "Batiment")
  Function for the main door: it checks
  which user is entering and automatically logs their entry

  compare_role(%Badge{} = badge, access_point)
  Function for the time clock or door in the building.
  It checks which user is entering/swiping their badge and updates their status based on the current status.
  If the user is authorized based on their role, the function will add “in” if the user enters and “out” if the user exits.
  """
  def compare_role(%Badge{} = badge, access_point = "Batiment") do
    badge = Repo.preload(badge, user: :role)
    access_point = get_access_points_by_name(access_point)

    if (badge.user.role in access_point.roles) do

      IO.inspect("USER PEUX RENTRée DANS BATIMENT")
      Log.changeset_logs(%Log{}, %{type: :int, clocked_at: DateTime.utc_now(), badge_id: badge.id, user_id: badge.user.id, access_point_id: access_point.id})
      |> Repo.insert()

    else
      IO.inspect("USER PEUX PAS RENTRée DANS BATIMENT")
    end
  end

  def compare_role(%Badge{} = badge, access_point) do
    badge = Repo.preload(badge, user: :role)
    access_point = get_access_points_by_name(access_point)

    if (badge.user.role in access_point.roles) do

      type = case Logs.get_logs_user_today(badge.user.lastname) do
        {:ok, nil} -> :in
        {:ok, %{type: :in}} -> :out
        {:ok, %{type: :out}} -> :in
        {:ok, %{type: "in"}} -> :out
        {:ok, %{type: "out"}} -> :in
      end
      IO.inspect("USER PEUX SORTIR")
      Log.changeset_logs(%Log{}, %{type: type, clocked_at: DateTime.utc_now(), badge_id: badge.id, user_id: badge.user.id, access_point_id: access_point.id})
      |> Repo.insert()

    else
      IO.inspect("USER PEUX PAS SORTIR")
    end
  end

  def badge_valid(rfid, access_point) do

    case get_access_points_by_name(access_point) do
      nil -> IO.inspect("access point n'existe pas")
      %AccessPoints{} ->
      case badge = BadgeManager.get_badge_by_rfid(rfid) do
        nil ->
          {:error, badge}
        %Badge{} ->
          compare_role(badge, access_point)
      end
    end
  end
end
