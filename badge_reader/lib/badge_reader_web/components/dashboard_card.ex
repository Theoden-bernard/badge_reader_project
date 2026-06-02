defmodule BadgeReaderWeb.DashboardCard do
  use Phoenix.Component
  import BadgeReaderWeb.ChartComponents
  import BadgeReaderWeb.EditMenu

  defp generer_les_dernieres_heures(nombre_d_heures) do
    heure_actuelle = Time.utc_now()

    (nombre_d_heures - 1)..0
    |> Enum.map(fn x ->
      heure_actuelle
      |> Time.add(-x * 3600)
      |> Map.put(:minute, 0)
      |> Time.to_string()
      |> String.slice(0..4)
    end)
  end

  attr :customers, :list, default: []
  attr :is_open, :boolean, default: false
  attr :on_toggle, :any, default: nil

  def dashboard_card_08(assigns) do

  end
end
