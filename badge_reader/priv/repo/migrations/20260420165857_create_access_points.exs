defmodule BadgeReader.Repo.Migrations.CreateAccessPoints do
  use Ecto.Migration

  def change do
    create table(:access_points) do
      add :nom_access_points, :string
      add :places, :string
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:access_points, [:user_id])
  end
end
