defmodule BadgeReader.AccessPointsManager.AccessPoints do
  use Ecto.Schema
  import Ecto.Changeset

  schema "access_points" do
    field :nom_access_points, :string
    field :places, :string

    many_to_many :roles, BadgeReader.RoleManager.Role,
      join_through: "roles_access_points",
      join_keys: [access_point_id: :id, role_id: :id],
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset_access_points(access_points, attrs, roles \\ []) do
    access_points
    |> cast(attrs, [:nom_access_points, :places])
    |> validate_required([:nom_access_points, :places])
    |> put_assoc(:roles, roles)
  end
end
