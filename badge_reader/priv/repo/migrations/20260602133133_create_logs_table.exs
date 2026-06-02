defmodule BadgeReader.Repo.Migrations.CreateLogsTable do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :type, :string, null: false
      add :clocked_at, :utc_datetime, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :badge_id, references(:badges, on_delete: :nilify_all), null: false
      add :access_point_id, references(:access_points, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:logs, [:user_id])
    create index(:logs, [:clocked_at])
  end
end
