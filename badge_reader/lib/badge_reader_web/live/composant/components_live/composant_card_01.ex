defmodule BadgeReaderWeb.Composant.ComponentsLive.ComposantCard01 do
  use BadgeReaderWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{}, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col col-span-full sm:col-span-6 xl:col-span-4 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="px-5 pt-5">
        <header class="flex justify-between items-start mb-2">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Simulation d'entrée de badge
          </h2>
        </header>
        <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-1">
          Selectionnée un utilisateur :
        </div>
        <div class="flex items-start">

        </div>
      </div>
    </div>
    """
  end
end
