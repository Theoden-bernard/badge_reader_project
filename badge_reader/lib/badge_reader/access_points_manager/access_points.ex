defmodule BadgeReader.AccessPointsManager.AccessPoints do
  use Ecto.Schema
  import Ecto.Changeset

  schema "access_points" do
    field :nom_access_points, :string
    field :places, :string

    many_to_many :roles, BadgeReader.Accounts.Role,
      join_through: "roles_access_points"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(access_points, attrs, user_scope) do
    access_points
    |> cast(attrs, [:nom_access_points, :places])
    |> validate_required([:nom_access_points, :places])
    |> put_change(:user_id, user_scope.user.id)
  end
end
