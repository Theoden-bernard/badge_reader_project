defmodule BadgeReader.Logs do
  alias BadgeReader.Logs.Log
  alias BadgeReader.Repo

  import Ecto.Query
  def list_logs() do
    Log
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def get_logs_user(lastname_user) do
    Log
    |> where(user_id: ^BadgeReader.Accounts.get_user_by_lastname(lastname_user).id)
    |> Repo.all()
  end

  def get_logs_user_today(lastname_user) do

    today = Date.utc_today()

    Log
    |> where(user_id: ^BadgeReader.Accounts.get_user_by_lastname(lastname_user).id)
    |> where([d], fragment("?::date = ?", d.clocked_at, ^today))
    |> order_by(desc: :clocked_at)
    |> limit(1)
    |> Repo.one()
  end
end
