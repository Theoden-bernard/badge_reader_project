defmodule BadgeReader.AccessPointsManager do
  alias BadgeReader.AccessPointsManager.AccessPoints
  alias BadgeReader.Repo
  alias BadgeReader.RoleManager.Role
  # alias BadgeReader.RoleManager

  import Ecto.Query

  def create_access_point(attrs, role_ids) do
    roles = Repo.all(from r in Role, where: r.id in ^role_ids)

    %AccessPoints{}
    |> AccessPoints.changeset_access_points(attrs, roles)
    |> Repo.insert()
  end

  def list_access_points() do
    AccessPoints
    |> Repo.all()
    |> Repo.preload([:roles])
  end

end
