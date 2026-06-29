defmodule BadgeReader.BadgeManager do
  @moduledoc """
  The BadgeManager context.

  Provides a set of functions to provision physical or dematerialized access badges,
  manage their hardware identification properties (RFID tokens), and cross-reference records
  with system identities.

  ## Features

  * **Badge Provisioning:** Employs structural changesets to persist individual operational badge entries into the database.
  * **Relational Directories:** Returns structural system logs completely preloaded alongside their matching core user profiles.
  * **Hardware Signal Processing:** Evaluates incoming localized binary signatures against backend parameters using individual unique identifiers (`rfid`).

  ## Examples

  Registering a fresh physical transponder element into the asset directory:

    {:ok, badge} = BadgeReader.BadgeManager.create_badge(%{name_badge: "Badge Principal", rfid: "A1B2C3D4"})

  Locating a badge profile on an incoming hardware scan event:

    badge = BadgeReader.BadgeManager.get_badge_by_rfid("A1B2C3D4")
  """

  alias BadgeReader.BadgeManager.Badge
  alias BadgeReader.Repo

  import Ecto.Query

  def create_badge(attrs) do
    %Badge{}
    |> Badge.changeset_badge(attrs)
    |> Repo.insert()
  end

  def list_badge do
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
