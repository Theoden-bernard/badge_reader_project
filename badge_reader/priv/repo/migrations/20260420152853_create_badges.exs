defmodule BadgeReader.Repo.Migrations.CreateBadges do
  use Ecto.Migration

  def change do
    create table(:badges) do
      add :rfid, :integer
      add :name_badge, :string, size: 50
      add :date_activation, :naive_datetime, default: fragment("now()")
      add :date_expiration, :naive_datetime, default: fragment("now() + INTERVAL '1 year'")
      add :status, :boolean, default: false, null: true

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:badges, [:user_id])
  end
end
