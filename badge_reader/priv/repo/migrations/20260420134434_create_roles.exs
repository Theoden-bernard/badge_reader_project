defmodule BadgeReader.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name_role, :string, size: 50

      timestamps(type: :utc_datetime)
    end
  end
end
