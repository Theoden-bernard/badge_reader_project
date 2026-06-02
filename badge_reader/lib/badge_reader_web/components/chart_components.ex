defmodule BadgeReaderWeb.ChartComponents do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div id={@id} class="w-full">
      <div id={"#{@id}-chart-container"} phx-update="ignore" style="position: relative; height: 100%; width: 100%;">
        <canvas
          id={"#{@id}-canvas"}
          phx-hook="LineChart"
          data-points={Jason.encode!(@points)}
        />
      </div>
    </div>
    """
  end
end
