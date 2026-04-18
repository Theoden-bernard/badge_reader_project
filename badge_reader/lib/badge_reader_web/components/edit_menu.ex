defmodule BadgeReaderWeb.EditMenu do
  use Phoenix.Component

  attr :is_open, :boolean, required: true
  attr :on_toggle, :any, required: true
  slot :inner_block, required: true

  def edit_menu(assigns) do
    ~H"""
    <div class="relative">
      <button
        phx-click={@on_toggle}
        class="text-gray-400 hover:text-gray-500 rounded-full"
      >
        <span class="sr-only">Menu</span>
        <svg class="w-8 h-8 fill-current" viewBox="0 0 32 32">
          <circle cx="16" cy="16" r="2" />
          <circle cx="10" cy="16" r="2" />
          <circle cx="22" cy="16" r="2" />
        </svg>
      </button>

      <%= if @is_open do %>
        <div class="absolute top-full right-0 min-w-40 bg-white dark:bg-gray-800 border border-gray-700 rounded-md shadow-lg z-10 p-2">
          <%= render_slot(@inner_block) %>
        </div>
      <% end %>
    </div>
    """
  end
end
