defmodule BadgeReader.BadgeManager do
  alias BadgeReader.BadgeManager.Badge
  alias BadgeReader.Repo

  import Ecto.Query

  def create_badge(attrs) do
    %Badge{}
    |> Badge.changeset_badge(attrs)
    |> Repo.insert()
  end

  def list_badge() do
    Badge
    |> Repo.all()
    |> Repo.preload([:user])
  end

  def get_badge_by_rfid(rfid) do
    Badge
    |> where(rfid: ^rfid)
    |> Repo.one()
  end
end
