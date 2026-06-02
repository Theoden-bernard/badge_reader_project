defmodule BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard02 do
  use BadgeReaderWeb, :live_component
  import BadgeReaderWeb.EditMenu

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{is_open: is_open, on_toggle: on_toggle}, socket) do
    {:ok,
    socket
    |> assign(:is_open, is_open)
    |> assign(:on_toggle, on_toggle)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="px-5 pt-5">
        <header class="flex justify-between items-start mb-2">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Étudiants
          </h2>
          <%!-- Menu button --%>
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
        <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-1">
          Personne
        </div>
        <div class="flex items-start">
          <div class="text-3xl font-bold text-gray-800 dark:text-gray-100 mr-2">17</div>
          <div class="text-sm font-medium text-red-500 px-1.5 bg-red-500/20 rounded-full">-5%</div>
        </div>
      </div>
      <div class="px-2 py-2">
        <.live_component
        module={BadgeReaderWeb.ChartComponents}
        id="nbr_etudiants"
        points={%{labels: ["jan", "fev", "mars", "avr", "mai"], values: [10, 23, 15, 50, 5]}}
        />
      </div>
    </div>
    """
  end
end
