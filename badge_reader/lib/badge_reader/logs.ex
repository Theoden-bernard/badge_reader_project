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

  def count_logs_user_today() do

    today = Date.utc_today()

    Log
    |> where([d], fragment("?::date = ?", d.clocked_at, ^today))
    |> where(type: :in)
    # |> order_by(desc: :clocked_at)
    |> select([d], count(d.user_id, :distinct))
    |> Repo.one()
  end

  def count_logs_user_today_by_role(role) do

    today = Date.utc_today()

    Log
    |> join(:inner, [l], u in assoc(l, :user))
    |> where([l], fragment("?::date = ?", l.clocked_at, ^today))
    |> where([l], type: :in)
    |> where([l, u], u.role_id == ^BadgeReader.RoleManager.get_role_by_name(role).id)
    |> select([l], count(l.user_id, :distinct))
    |> Repo.one()
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
