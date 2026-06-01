defmodule BadgeReaderWeb.UserManager.ComponentsLive.UserProfileCard03 do
  use BadgeReaderWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{}, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60 flex items-center">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">Vos évènements</h2>
        </div>
      </header>
    </div>
    """
  end
end
