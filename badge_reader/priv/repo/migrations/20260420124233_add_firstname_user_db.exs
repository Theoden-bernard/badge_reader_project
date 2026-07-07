defmodule BadgeReader.Repo.Migrations.AddFirstnameUserDb do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :firstname, :string, size: 50
      add :lastname, :string, size: 50
    end
  end
end
