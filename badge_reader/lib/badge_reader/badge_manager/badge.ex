defmodule BadgeReader.BadgeManager.Badge do
  use Ecto.Schema
  import Ecto.Changeset

  schema "badges" do
    field :rfid, :integer
    field :name_badge, :string
    field :date_activation, :utc_datetime, read_after_writes: true
    field :date_expiration, :utc_datetime, read_after_writes: true
    field :status, :boolean, default: false

    belongs_to :user, BadgeReader.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset_badge(%BadgeReader.BadgeManager.Badge{} = badge, attrs) do
    badge
    |> cast(attrs, [:rfid, :name_badge, :date_activation, :date_expiration, :status, :user_id])
    |> validate_required([
      :rfid,
      :name_badge,
      :date_activation,
      :date_expiration,
      :status,
      :user_id
    ])
    |> validate_length(:name_badge, max: 50)
  end
end
