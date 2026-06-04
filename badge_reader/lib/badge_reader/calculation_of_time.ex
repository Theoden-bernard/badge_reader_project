defmodule BadgeReader.CalculationOfTime do

  def days(1), do: "Lun"
  def days(2), do: "Mar"
  def days(3), do: "Mer"
  def days(4), do: "Jeu"
  def days(5), do: "Ven"
  def days(6), do: "Sam"
  def days(7), do: "Dim"

  def calculation_of_the_week() do
    %{
      today: Date.day_of_week(DateTime.utc_now()),
      yesteday: Date.day_of_week(Date.add(Date.utc_today(), -1)),
      three_days_ago: Date.day_of_week(Date.add(Date.utc_today(), -2)),
      four_days_ago: Date.day_of_week(Date.add(Date.utc_today(), -3)),
      five_days_ago: Date.day_of_week(Date.add(Date.utc_today(), -4)),
      six_days_ago: Date.day_of_week(Date.add(Date.utc_today(), -5)),
      seven_days_ago: Date.day_of_week(Date.add(Date.utc_today(), -6))
    }
  end
end
