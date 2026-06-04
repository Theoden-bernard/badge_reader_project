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

    case BadgeReader.Accounts.get_user_by_lastname(lastname_user) do
      nil ->
        {:error, "le nom d'utilisateur '#{lastname_user}' n'existe pas."}
      user ->
        logs =
          Log
          |> where(user_id: ^user.id)
          |> Repo.all()
        {:ok, logs}
    end

  end

  def count_logs_user_today() do

    today = Date.utc_today()

    Log
    |> where([d], fragment("?::date = ?", d.clocked_at, ^today))
    |> where(type: :in)
    |> select([d], count(d.user_id, :distinct))
    |> Repo.one()
  end

  def count_logs_user_today_by_role(role) do

    today = Date.utc_today()

    case BadgeReader.RoleManager.get_role_by_name(role) do
      nil ->
        {:error, "Le rôle '#{role}' n'existe pas."}
      role ->
        count =
          Log
          |> join(:inner, [l], u in assoc(l, :user))
          |> where([l], fragment("?::date = ?", l.clocked_at, ^today))
          |> where([l], type: :in)
          |> where([l, u], u.role_id == ^role.id)
          |> select([l], count(l.user_id, :distinct))
          |> Repo.one()
        {:ok, count}
    end
  end

  def get_logs_user_today(lastname_user) do

    today = Date.utc_today()

    case BadgeReader.Accounts.get_user_by_lastname(lastname_user) do
      nil ->
        {:error, "l'utilisateur '#{lastname_user}' n'existe pas"}
      lastname ->
        user =
          Log
          |> where(user_id: ^lastname.id)
          |> where([d], fragment("?::date = ?", d.clocked_at, ^today))
          |> order_by(desc: :clocked_at)
          |> limit(1)
          |> Repo.one()
        {:ok, user}
    end
  end

  def list_logs_user_by_day_and_by_role(day, role) do
    case BadgeReader.RoleManager.get_role_by_name(role) do
      nil ->
        {:error, "Le rôle '#{role}' n'existe pas."}
      role ->
        logs =
          Log
          |> join(:inner, [l], u in assoc(l, :user))
          |> where([l], fragment("?::date = ?", l.clocked_at, ^DateTime.to_date(day)))
          |> where([l, u], u.role_id == ^role.id)
          |> Repo.all()
        {:ok, logs}
    end
  end

  def count_logs_user_by_day_and_by_role(day, role) do
    case BadgeReader.RoleManager.get_role_by_name(role) do
      nil ->
        {:error, "Le rôle '#{role}' n'existe pas."}
      role ->
        count =
          Log
          |> join(:inner, [l], u in assoc(l, :user))
          |> where([l], fragment("?::date = ?", l.clocked_at, ^day))
          |> where([l, u], u.role_id == ^role.id)
          |> select([l], count(l.user_id, :distinct))
          |> Repo.one()
        {:ok, count}
    end
  end

  def count_logs_user_by_day(day) do
    Log
    |> where([l], fragment("?::date = ?", l.clocked_at, ^day))
    |> select([l], count(l.user_id, :distinct))
    |> Repo.one()
  end

end
