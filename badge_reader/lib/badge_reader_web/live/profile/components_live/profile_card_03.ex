defmodule BadgeReaderWeb.Profile.ComponentsLive.ProfileCard03 do
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
    <div class="flex flex-col h-full bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60 flex items-center">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">Vos évènements</h2>
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
        </div>
      </header>
    </div>
    """
  end
end
