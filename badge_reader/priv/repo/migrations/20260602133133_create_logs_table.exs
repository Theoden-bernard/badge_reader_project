defmodule BadgeReader.Repo.Migrations.CreateLogsTable do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :type, :string, size: 5, null: false
      add :clocked_at, :utc_datetime, null: false

      add :badge_id, references(:badges, on_delete: :nothing), null: false
      add :access_point_id, references(:access_points, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:logs, [:badge_id])
    create index(:logs, [:clocked_at])
  end
end
