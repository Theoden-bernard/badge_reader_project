defmodule BadgeReaderWeb.EditMenu do
  @moduledoc """
  A reusable, presentational Phoenix Component that provides a contextual action dropdown menu.

  This module encapsulates a standard "three-dots" (ellipsis) trigger button and an absolute-positioned
  floating overlay container. It leverages Phoenix component slots to let invoking templates inject
  custom contextual action lists dynamically.

  ## Features

  * **Slot Injection:** Exposes a required `:inner_block` default slot to accept custom navigation lists, action buttons, or interactive trigger controls.
  * **Event Delegation:** Dispatches the click toggle command directly back up to a customizable parent event handler string or target defined via the `@on_toggle` attribute.
  * **Adaptive Presentation:** Uses conditional structural checks (`@is_open`) alongside absolute utility classes to render floating contextual menus safely above other background view elements.

  ## Examples

  Using the menu inside an operational card wrapper component:

    <.edit_menu is_open={@menu_open?} on_toggle="toggle_card_actions">
      <ul class="text-sm">
        <li>
          <button phx-click="edit_item" class="block w-full text-left px-3 py-1.5 hover:bg-gray-100">
            Modifier
          </button>
        </li>
        <li class="border-t border-gray-200 mt-1 pt-1">
          <button phx-click="delete_item" class="block w-full text-left px-3 py-1.5 text-red-500">
            Supprimer
          </button>
        </li>
      </ul>
    </.edit_menu>
  """

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
          {render_slot(@inner_block)}
        </div>
      <% end %>
    </div>
    """
  end
end
