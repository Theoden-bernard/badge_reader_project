defmodule BadgeReaderWeb.UserManager.ComponentsLive.UserProfileCard01 do
  use BadgeReaderWeb, :live_component
  import BadgeReaderWeb.EditMenu

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{is_open: is_open, on_toggle: on_toggle}, socket)do
    {:ok,
    socket
    |> assign(:is_open, is_open)
    |> assign(:on_toggle, on_toggle)}
  end

  def render(assigns)do
    ~H"""
    <div class="flex flex-col h-full bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="w-full px-5">
        <header class="flex justify-between items-start pt-4">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Son Activiter
          </h2>
          <.edit_menu is_open={@is_open} on_toggle={@on_toggle}>
            <ul class="text-sm">
              <li>
                <button class="block w-full text-left font-medium text-black dark:text-gray-200 hover:text-gray-500 dark:hover:text-white py-1.5 px-3">
                  Option 1
                </button>
              </li>
              <li>
                <button class="block w-full text-left font-medium text-black dark:text-gray-200 hover:text-gray-500 dark:hover:text-white py-1.5 px-3">
                  Option 2
                </button>
              </li>
              <li class="border-t border-gray-700 mt-1 pt-1">
                <button class="block w-full text-left font-medium text-red-500 hover:text-red-400 py-1.5 px-3">
                  Remove
                </button>
              </li>
            </ul>
          </.edit_menu>
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
