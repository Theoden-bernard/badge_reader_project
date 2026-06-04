defmodule BadgeReader.Logs.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :type, Ecto.Enum, values: [:in, :out]
    field :clocked_at, :utc_datetime

    belongs_to :user, BadgeReader.Accounts.User
    belongs_to :badge, BadgeReader.BadgeManager.Badge
    belongs_to :access_point, BadgeReader.AccessPointsManager.AccessPoints

    timestamps(type: :utc_datetime)
  end

  def changeset_logs(%BadgeReader.Logs.Log{} = logs, attrs) do
    logs
    |> cast(attrs, [:type, :clocked_at, :user_id, :badge_id, :access_point_id])
    |> validate_required([:type, :clocked_at, :user_id, :badge_id, :access_point_id])
  end
end
