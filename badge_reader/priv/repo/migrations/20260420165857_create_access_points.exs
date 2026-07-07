defmodule BadgeReader.Repo.Migrations.CreateAccessPoints do
  use Ecto.Migration

  def change do
    create table(:access_points) do
      add :name_access_points, :string, size: 50, null: false
      add :places, :string, size: 50, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
