defmodule BadgeReader.Repo.Migrations.EditTimestempIntoBadgeTable do
  use Ecto.Migration

  def change do
    alter table(:badges) do
      modify :date_activation, :utc_datetime, from: :naive_datetime
      modify :date_expiration, :utc_datetime, from: :naive_datetime
    end
  end
end
