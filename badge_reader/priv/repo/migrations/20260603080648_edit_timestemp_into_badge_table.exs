defmodule BadgeReader.Repo.Migrations.EditTimestempIntoBadgeTable do
  use Ecto.Migration

  def change do
    alter table(:badges) do
      modify :date_activation, :utc_datetime,
        from: :naive_datetime,
        default: fragment("timezone('utc', now())")

      modify :date_expiration, :utc_datetime,
        from: :naive_datetime,
        default: fragment("timezone('utc', now() + INTERVAL '1 year')")
    end
  end
end
