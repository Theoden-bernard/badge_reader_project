defmodule BadgeReader.AccessPointsManager do
  @moduledoc """
  The AccessPointsManager context.

  Provides functions to manage physical building access points, administer role-based
  permission lists for gateways, and process real-time badge scanning authentication loops.

  ## Features

  * **Access Point Provisioning:** Creates and modifies access points paired with safe multi-role permissions.
  * **Role Validation & Entry Logging:** Intercepts RFID scans, matching a user's role against the endpoint's allowed definitions.
  * **Dynamic State Detection:** Automatically deduces standard attendance shifts (`:in` or `:out`) by analyzing historical tracking records for the same operating day.
  * **Real-Time Integration:** Broadcasts successful check-in logs down decentralized event pipes (`"logs:new"`) using Phoenix PubSub clusters.

  ## Examples

  Listing checkpoints with preloaded validation layers:

    BadgeReader.AccessPointsManager.list_access_points()

  Evaluating entry credentials on a physical RFID sensor terminal scan:

    BadgeReader.AccessPointsManager.badge_valid("rfid_token_123", "Batiment")
  """

  alias BadgeReader.AccessPointsManager.AccessPoints
  alias BadgeReader.BadgeManager
  alias BadgeReader.BadgeManager.Badge
  alias BadgeReader.Logs
  alias BadgeReader.Logs.Log
  alias BadgeReader.Repo
  alias BadgeReader.RoleManager.Role

  import Ecto.Query
  require Logger

  def create_access_point(attrs, role_ids) do
    roles = Repo.all(from r in Role, where: r.id in ^role_ids)

    %AccessPoints{}
    |> AccessPoints.changeset_access_points(attrs, roles)
    |> Repo.insert()
  end

  def edit_access_point(name_access_point, attrs) do
    case Repo.update(Ecto.Changeset.change(get_access_points_by_name(name_access_point), attrs)) do
      {:ok, _struct} -> Logger.debug("acesse_point update")
      {:error, _changeset} -> Logger.debug("access_point error update")
    end
  end

  def list_access_points do
    AccessPoints
    |> Repo.all()
    |> Repo.preload([:roles])
  end

  def get_access_points_by_name(name) do
    AccessPoints
    |> where(name_access_points: ^name)
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
  def compare_role(%Badge{} = badge, "Batiment" = access_point) do
    badge = Repo.preload(badge, user: :role)
    access_point = get_access_points_by_name(access_point)

    if badge.user.role in access_point.roles do
      Logger.debug("USER NE PEUX PAS ENTRÉE")

      Log.changeset_logs(%Log{}, %{
        type: :in,
        clocked_at: DateTime.utc_now(),
        badge_id: badge.id,
        user_id: badge.user.id,
        access_point_id: access_point.id
      })
      |> Repo.insert()
    else
      Logger.debug("USER NE PEUX PAS RENTRÉE DANS LE BATIMENT")
    end
  end

  def compare_role(%Badge{} = badge, access_point) do
    badge = Repo.preload(badge, user: :role)
    access_point = get_access_points_by_name(access_point)

    if badge.user.role in access_point.roles do
      type =
        case Logs.get_logs_user_today(badge.user.lastname) do
          {:ok, nil} -> :in
          {:ok, %{type: :in}} -> :out
          {:ok, %{type: :out}} -> :in
          {:ok, %{type: "in"}} -> :out
          {:ok, %{type: "out"}} -> :in
        end

      case Log.changeset_logs(%Log{}, %{
             type: type,
             clocked_at: DateTime.utc_now(),
             badge_id: badge.id,
             user_id: badge.user.id,
             access_point_id: access_point.id
           })
           |> Repo.insert() do
        {:ok, real_log} ->
          Phoenix.PubSub.broadcast(BadgeReader.PubSub, "logs:new", {:new_log, real_log})
          {:ok, real_log}

        {:error, changeset} ->
          {:error, changeset}
      end
    else
      Logger.debug("USER NE PEUX PAS SORTIR")
    end
  end

  def badge_valid(rfid, access_point) do
    case get_access_points_by_name(access_point) do
      nil ->
        Logger.debug("access point n'existe pas")

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
