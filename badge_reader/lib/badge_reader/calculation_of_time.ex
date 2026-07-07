defmodule BadgeReader.CalculationOfTime do
  @moduledoc """
  Provides time tracking computations, aggregation metrics, and weekly data structures.

  This module handles calculating hours worked by an individual user over the span of
  a calendar week, as well as compiling workforce attendance logs over the past rolling seven days,
  optionally filtered by specific user roles. It formats data structures suitable for consumption
  by reporting views or charting components.

  ## Features

  * **Weekly Individual Tracking:** Backtracks to the start of the current week to map a user's hours worked per day (from Monday to Sunday).
  * **Rolling Historic Analytics:** Compiles attendance figures over a rolling 7-day window to evaluate overall check-in frequencies.
  * **Role-Based Aggregation:** Isolates global activity maps to compile daily statistics for specified organizational roles.

  ## Examples

  Compiling a user's logged metrics for the current week:

    BadgeReader.CalculationOfTime.this_week_calculation_by_user(user)

  Fetching the absolute check-in trends across the last seven days filtered by a specific group:

    {:ok, stats_map} = BadgeReader.CalculationOfTime.calculation_of_the_past_week_by_role("Developer")
  """

  alias BadgeReader.Logs

  def days(1), do: "Lun"
  def days(2), do: "Mar"
  def days(3), do: "Mer"
  def days(4), do: "Jeu"
  def days(5), do: "Ven"
  def days(6), do: "Sam"
  def days(7), do: "Dim"

  def earlier_this_week_by_user(day, user) do
    if Date.day_of_week(day) == 1 do
      %{
        monday: %{
          date: Date.day_of_week(day),
          value:
            Logs.hours_worked_per_day(
              BadgeReader.Accounts.get_user_by_lastname(user.lastname),
              day
            ) / 3600
        },
        tuesday: %{
          date: Date.day_of_week(Date.add(day, +1)),
          value:
            Logs.hours_worked_per_day(
              BadgeReader.Accounts.get_user_by_lastname(user.lastname),
              Date.add(day, +1)
            ) / 3600
        },
        wenesday: %{
          date: Date.day_of_week(Date.add(day, +2)),
          value:
            Logs.hours_worked_per_day(
              BadgeReader.Accounts.get_user_by_lastname(user.lastname),
              Date.add(day, +2)
            ) / 3600
        },
        thesday: %{
          date: Date.day_of_week(Date.add(day, +3)),
          value:
            Logs.hours_worked_per_day(
              BadgeReader.Accounts.get_user_by_lastname(user.lastname),
              Date.add(day, +3)
            ) / 3600
        },
        friday: %{
          date: Date.day_of_week(Date.add(day, +4)),
          value:
            Logs.hours_worked_per_day(
              BadgeReader.Accounts.get_user_by_lastname(user.lastname),
              Date.add(day, +4)
            ) / 3600
        },
        saturday: %{
          date: Date.day_of_week(Date.add(day, +5)),
          value:
            Logs.hours_worked_per_day(
              BadgeReader.Accounts.get_user_by_lastname(user.lastname),
              Date.add(day, +5)
            ) / 3600
        },
        sunday: %{
          date: Date.day_of_week(Date.add(day, +6)),
          value:
            Logs.hours_worked_per_day(
              BadgeReader.Accounts.get_user_by_lastname(user.lastname),
              Date.add(day, +6)
            ) / 3600
        }
      }
    else
      day = Date.add(day, -1)
      earlier_this_week_by_user(day, user)
    end
  end

  def this_week_calculation_by_user(user) do
    case Date.day_of_week(Date.utc_today()) do
      1 ->
        %{
          monday: %{
            date: Date.day_of_week(DateTime.utc_now()),
            value:
              Logs.hours_worked_per_day(
                BadgeReader.Accounts.get_user_by_lastname(user.lastname),
                Date.utc_today()
              )
          },
          tuesday: %{
            date: Date.day_of_week(Date.add(Date.utc_today(), +1)),
            value:
              Logs.hours_worked_per_day(
                BadgeReader.Accounts.get_user_by_lastname(user.lastname),
                Date.add(Date.utc_today(), +1)
              )
          },
          wenesday: %{
            date: Date.day_of_week(Date.add(Date.utc_today(), +2)),
            value:
              Logs.hours_worked_per_day(
                BadgeReader.Accounts.get_user_by_lastname(user.lastname),
                Date.add(Date.utc_today(), +2)
              )
          },
          thesday: %{
            date: Date.day_of_week(Date.add(Date.utc_today(), +3)),
            value:
              Logs.hours_worked_per_day(
                BadgeReader.Accounts.get_user_by_lastname(user.lastname),
                Date.add(Date.utc_today(), +3)
              )
          },
          friday: %{
            date: Date.day_of_week(Date.add(Date.utc_today(), +4)),
            value:
              Logs.hours_worked_per_day(
                BadgeReader.Accounts.get_user_by_lastname(user.lastname),
                Date.add(Date.utc_today(), +4)
              )
          },
          saturday: %{
            date: Date.day_of_week(Date.add(Date.utc_today(), +5)),
            value:
              Logs.hours_worked_per_day(
                BadgeReader.Accounts.get_user_by_lastname(user.lastname),
                Date.add(Date.utc_today(), +5)
              )
          },
          sunday: %{
            date: Date.day_of_week(Date.add(Date.utc_today(), +6)),
            value:
              Logs.hours_worked_per_day(
                BadgeReader.Accounts.get_user_by_lastname(user.lastname),
                Date.add(Date.utc_today(), +6)
              )
          }
        }

      _ ->
        earlier_this_week_by_user(Date.utc_today(), user)
    end
  end

  def calculation_of_the_past_week do
    %{
      today: %{
        date: Date.day_of_week(DateTime.utc_now()),
        value: BadgeReader.Logs.count_logs_user_today()
      },
      yesteday: %{
        date: Date.day_of_week(Date.add(Date.utc_today(), -1)),
        value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -1))
      },
      three_days_ago: %{
        date: Date.day_of_week(Date.add(Date.utc_today(), -2)),
        value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -2))
      },
      four_days_ago: %{
        date: Date.day_of_week(Date.add(Date.utc_today(), -3)),
        value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -3))
      },
      five_days_ago: %{
        date: Date.day_of_week(Date.add(Date.utc_today(), -4)),
        value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -4))
      },
      six_days_ago: %{
        date: Date.day_of_week(Date.add(Date.utc_today(), -5)),
        value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -5))
      },
      seven_days_ago: %{
        date: Date.day_of_week(Date.add(Date.utc_today(), -6)),
        value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -6))
      }
    }
  end

  def calculation_of_the_past_week_by_role(role) do
    today = Date.utc_today()

    d0 = today
    d1 = Date.add(today, -1)
    d2 = Date.add(today, -2)
    d3 = Date.add(today, -3)
    d4 = Date.add(today, -4)
    d5 = Date.add(today, -5)
    d6 = Date.add(today, -6)

    with {:ok, v0} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d0, role),
         {:ok, v1} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d1, role),
         {:ok, v2} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d2, role),
         {:ok, v3} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d3, role),
         {:ok, v4} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d4, role),
         {:ok, v5} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d5, role),
         {:ok, v6} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d6, role) do
      %{
        today: %{date: Date.day_of_week(d0), value: v0},
        yesteday: %{date: Date.day_of_week(d1), value: v1},
        three_days_ago: %{date: Date.day_of_week(d2), value: v2},
        four_days_ago: %{date: Date.day_of_week(d3), value: v3},
        five_days_ago: %{date: Date.day_of_week(d4), value: v4},
        six_days_ago: %{date: Date.day_of_week(d5), value: v5},
        seven_days_ago: %{date: Date.day_of_week(d6), value: v6}
      }
    else
      {:error, raison} ->
        {:error, raison}
    end
  end
end
