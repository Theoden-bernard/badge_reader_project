defmodule BadgeReaderWeb.ChartComponents do
  use Phoenix.Component
  alias Contex.{Dataset, Plot, LinePlot}

  def native_sparkline(assigns) do
    indexed_data =
      assigns.data
      |> Enum.with_index()
      |> Enum.map(fn {val, idx} -> [idx, val] end)

    dataset = Dataset.new(indexed_data, ["x", "y"])

    _line_plot = LinePlot.new(dataset)

    plot =
    Plot.new(dataset, LinePlot, 550, 150)
    |> Plot.titles("", "")
    |> Plot.plot_options(%{
      smoothed: true,
      fill_opacity: 0.2,
      stroke_width: 3,
      colour_palette: ["#fed401"],
      show_x_axis: false,
      show_y_axis: false
    })

    assigns = assign(assigns, :svg_render, Plot.to_svg(plot))

    ~H"""
    <div class="w-full h-full overflow-hidden flex items-end">
      <%= Phoenix.HTML.raw(@svg_render) %>
    </div>
    """
  end

  attr :data, :list, required: true
  attr :title, :string, default: ""

  def native_pie_chart(assigns) do
    dataset = Dataset.new(assigns.data, [:category, :value])

    mapping = %{category_col: :category, value_col: :value}

    plot =
      Plot.new(dataset, Contex.PieChart, 300, 250, [mapping: mapping])
      |> Plot.titles(assigns.title, "")
      |> Plot.plot_options(%{
        show_labels: true,
        colour_scheme: ["#4F46E5", "#F43F5E", "#F59E0B"]
      })

    assigns = assign(assigns, :svg, Plot.to_svg(plot))

    ~H"""
    <div class="flex justify-center items-center w-full h-full native-pie-container">
      <%= Phoenix.HTML.raw(@svg) %>
    </div>
    """
  end
end
