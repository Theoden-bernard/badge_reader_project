defmodule BadgeReader.Repo.Migrations.CreateRolesAccessPoints do
  use Ecto.Migration

  def change do
    create table(:roles_access_points, primary_key: false) do
      add :role_id, references(:roles, on_delete: :delete_all), null: false
      add :access_point_id, references(:access_points, on_delete: :delete_all), null: false
    end

    create unique_index(:roles_access_points, [:role_id, :access_point_id])
  end
end
