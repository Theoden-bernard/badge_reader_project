defmodule BadgeReaderWeb.ChartComponents do
  @moduledoc """
  A reusable, stateful LiveComponent that handles hardware-accelerated charting and visual graphing canvas instances.

  This component acts as a generic bridge to a client-side JavaScript graphing framework (e.g., Chart.js)
  by rendering a responsive canvas tag linked to a custom Phoenix client Hook.

  ## Features

  * **DOM Isolation:** Employs `phx-update="ignore"` on the graphic element container to allow client-side layout updates to persist across state pushes safely without server side re-rendering conflicts.
  * **Inter-op Data Streaming:** Encodes data maps into standardized JSON lists using `Jason.encode!/1` inside a declarative HTML data property pipeline (`data-points`), allowing instant ingestion by client hooks.
  * **Asynchronous Lifecycles:** Pairs cleanly with a matching frontend JavaScript hook (`GenericChart`) to initialize, update, or resize specific canvas contexts dynamically.

  ## Examples

  Embedding a bar or line chart instance into a statistics dashboard container:

    <.live_component
      module={BadgeReaderWeb.ChartComponents}
      id="weekly-attendance-chart"
      points={[%{label: "Lun", value: 45}, %{label: "Mar", value: 52}]}
    />
  """

  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div id={@id} class="w-full h-full">
      <div
        id={"#{@id}-chart-container"}
        phx-update="ignore"
        style="position: relative; height: 100%; width: 100%;"
      >
        <canvas
          id={"#{@id}-canvas"}
          phx-hook="GenericChart"
          data-points={Jason.encode!(@points)}
        />
      </div>
    </div>
    """
  end
end
