defmodule BadgeReaderWeb.UserManager.ComponentsLive.UserProfileCard01 do
  use BadgeReaderWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{}, socket)do
    {:ok, socket}
  end

  def render(assigns)do
    ~H"""
    <div class="flex flex-col h-full bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="w-full px-5">
        <header class="flex justify-between items-start pt-4">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Son Activiter
          </h2>
        </header>
        <h3 class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-1">
          CETTE SEMAINE
        </h3>
      </div>

      <%!-- <BarChart data={chartData} width={595} height={248} /> --%>
    </div>
    """
  end
end
