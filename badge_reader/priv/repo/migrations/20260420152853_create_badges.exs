defmodule BadgeReader.Repo.Migrations.CreateBadges do
  use Ecto.Migration

  def change do
    create table(:badges) do
      add :rfid, :integer
      add :name_badge, :string
      add :date_activation, :naive_datetime
      add :date_expiration, :naive_datetime
      add :statue, :boolean, default: false, null: false

      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:badges, [:user_id])
  end
end
