defmodule BadgeReader.Logs do
  @moduledoc """
  The Logs context.

  Provides a set of functions to manage, query, and aggregate access logs generated
  by physical or dematerialized badge scans. It handles lookups by user and role,
  daily statistical computations, and workforce tracking calculations.

  ## Features

  * **Log Queries:** Fetches access logs coupled with relational associations (badges, users, roles).
  * **Daily Statistics:** Aggregates operational metrics such as the total volume of daily check-ins (`:in`) or unique active user counts filtered by specific roles.
  * **Time Tracking Calculations:** Computes chronological durations and active hours worked by users over fixed daily windows.

  ## Examples

  Listing all records with structural preloads:

      BadgeReader.Logs.list_logs()

  Fetching daily metrics for a designated profile role:

      {:ok, count} = BadgeReader.Logs.count_logs_user_today_by_role("Developer")
  """

  alias BadgeReader.Logs.Log
  alias BadgeReader.Repo

  import Ecto.Query

  def list_logs do
    Log
    |> Repo.all()
    |> Repo.preload(badge: :user)
  end

  def get_logs_user(lastname_user) do
    case BadgeReader.Accounts.get_user_by_lastname(lastname_user) do
      nil ->
        {:error, "le nom d'utilisateur '#{lastname_user}' n'existe pas."}

      user ->
        logs =
          Log
          |> join(:inner, [l], b in assoc(l, :badge))
          |> where(user_id: ^user.id)
          |> Repo.all()

        {:ok, logs}
    end
  end

  def count_logs_user_today do
    today = Date.utc_today()

    Log
    |> where([d], fragment("?::date = ?", d.clocked_at, ^today))
    |> where(type: :in)
    |> select([d], count(d.id))
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
          |> join(:inner, [l], b in assoc(l, :badge))
          |> join(:inner, [l, b], u in assoc(b, :user))
          |> where([l], fragment("?::date = ?", l.clocked_at, ^today))
          |> where([l], type: :in)
          |> where([l, b, u], u.role_id == ^role.id)
          # On compte les utilisateurs uniques via le badge
          |> select([l, b], count(b.user_id, :distinct))
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
        log =
          Log
          |> join(:inner, [l], b in assoc(l, :badge))
          |> where([l, b], b.user_id == ^lastname.id)
          |> where([l], fragment("?::date = ?", l.clocked_at, ^today))
          |> order_by(desc: :clocked_at)
          |> limit(1)
          |> Repo.one()

        {:ok, log}
    end
  end

  def list_logs_user_by_day_and_by_role(day, role) do
    case BadgeReader.RoleManager.get_role_by_name(role) do
      nil ->
        {:error, "Le rôle '#{role}' n'existe pas."}

      role ->
        logs =
          Log
          |> join(:inner, [l], b in assoc(l, :badge))
          |> join(:inner, [l, b], u in assoc(b, :user))
          |> where([l], fragment("?::date = ?", l.clocked_at, ^DateTime.to_date(day)))
          |> where([l, b, u], u.role_id == ^role.id)
          |> Repo.all()

        {:ok, logs}
    end
  end

  def list_logs_by_user_and_by_day(user, day) do
    start_of_day = DateTime.new!(day, ~T[00:00:00], "Etc/UTC")
    end_of_day = DateTime.new!(day, ~T[23:59:59], "Etc/UTC")

    Log
    |> join(:inner, [l], b in assoc(l, :badge))
    |> where([l], l.clocked_at >= ^start_of_day and l.clocked_at <= ^end_of_day)
    |> where([l, b], b.user_id == ^user.id)
    |> Repo.all()
  end

  def count_logs_user_by_day_and_by_role(day, role) do
    case BadgeReader.RoleManager.get_role_by_name(role) do
      nil ->
        {:error, "Le rôle '#{role}' n'existe pas."}

      role ->
        count =
          Log
          |> join(:inner, [l], b in assoc(l, :badge))
          |> join(:inner, [l, b], u in assoc(b, :user))
          |> where([l], fragment("?::date = ?", l.clocked_at, ^day))
          |> where([l, b, u], u.role_id == ^role.id)
          |> select([l, b], count(b.user_id, :distinct))
          |> Repo.one()

        {:ok, count}
    end
  end

  def count_logs_user_by_day(day) do
    Log
    |> join(:inner, [l], b in assoc(l, :badge))
    |> where([l], fragment("?::date = ?", l.clocked_at, ^day))
    |> select([l, b], count(b.user_id, :distinct))
    |> Repo.one()
  end

  def format_duration(seconde) do
    "#{div(seconde, 3600)}h#{div(rem(seconde, 3600), 60)}"
  end

  def hours_worked_per_day(user, day) do
    logs = list_logs_by_user_and_by_day(user, day)

    ins =
      Enum.filter(logs, fn log -> log.type == :in end)
      |> Enum.sort_by(fn log -> log.id end)
      |> List.first()

    outs =
      Enum.filter(logs, fn log -> log.type == :out end)
      |> Enum.sort_by(fn log -> log.id end)
      |> List.last()

    case {ins, outs} do
      {nil, _} -> 0
      {_, nil} -> 0
      {_, _} -> DateTime.diff(outs.clocked_at, ins.clocked_at)
    end
  end

  def delete_log(%Log{} = log) do
    Repo.delete(log)
  end
end
