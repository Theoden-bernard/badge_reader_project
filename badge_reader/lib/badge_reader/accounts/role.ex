defmodule BadgeReader.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name_role, :string

    has_many :users, BadgeReader.Accounts.User

    many_to_many :access_points, BadgeReader.Accounts.AccessPoints,
      join_through: "roles_access_points",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs, user_scope) do
    role
    |> cast(attrs, [:name_role])
    |> validate_required([:name_role])
    |> put_change(:user_id, user_scope.user.id)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name_role])
    |> validate_required([:name_role])
  end
end
