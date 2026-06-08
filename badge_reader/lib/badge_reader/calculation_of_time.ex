defmodule BadgeReader.CalculationOfTime do

  alias BadgeReader.Logs.Log

  def days(1), do: "Lun"
  def days(2), do: "Mar"
  def days(3), do: "Mer"
  def days(4), do: "Jeu"
  def days(5), do: "Ven"
  def days(6), do: "Sam"
  def days(7), do: "Dim"

  def calculation_of_the_week() do
    %{
      today: %{date: Date.day_of_week(DateTime.utc_now()), value: BadgeReader.Logs.count_logs_user_today()},
      yesteday: %{date: Date.day_of_week(Date.add(Date.utc_today(), -1)), value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -1))},
      three_days_ago: %{date: Date.day_of_week(Date.add(Date.utc_today(), -2)), value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -2))},
      four_days_ago: %{date: Date.day_of_week(Date.add(Date.utc_today(), -3)), value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -3))},
      five_days_ago: %{date: Date.day_of_week(Date.add(Date.utc_today(), -4)), value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -4))},
      six_days_ago: %{date: Date.day_of_week(Date.add(Date.utc_today(), -5)), value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -5))},
      seven_days_ago: %{date: Date.day_of_week(Date.add(Date.utc_today(), -6)), value: BadgeReader.Logs.count_logs_user_by_day(Date.add(Date.utc_today(), -6))}
    }
  end

  def calculation_of_the_week_by_role(role) do
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
      {:ok, v6} <- BadgeReader.Logs.count_logs_user_by_day_and_by_role(d6, role)
      do

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
