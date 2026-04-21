defmodule BadgeReader.Accounts.Badge do
  use Ecto.Schema
  import Ecto.Changeset

  alias BadgeReader.Repo
  alias BadgeReader.Badges.Badge

  schema "badges" do
    field :rfid, :integer
    field :name_badge, :string
    field :date_activation, :naive_datetime
    field :date_expiration, :naive_datetime
    field :statue, :boolean, default: false

    belongs_to :user, BadgeReader.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(badge, attrs, user_scope) do
    badge
    |> cast(attrs, [:rfid, :name_badge, :date_activation, :date_expiration, :statue])
    |> validate_required([:rfid, :name_badge, :date_activation, :date_expiration, :statue])
    |> put_change(:user_id, user_scope.user.id)
  end

  # def delete_all_user_badges(user_id) do
  #   Repo.delete_all(from b in Badge, where: b.user_id == ^user_id)
  # end
end
