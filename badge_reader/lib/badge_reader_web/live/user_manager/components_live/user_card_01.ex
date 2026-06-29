defmodule BadgeReaderWeb.UserManager.ComponentsLive.UserCard01 do
  use BadgeReaderWeb, :live_component
  import BadgeReaderWeb.EditMenu

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{user_table: user_table, is_open: is_open, on_toggle: on_toggle}, socket) do
    {:ok,
     socket
     |> assign(:user_table, user_table)
     |> assign(:is_open, is_open)
     |> assign(:on_toggle, on_toggle)}
  end

  def render(assigns) do
    ~H"""
    <div class="col-span-full xl:col-span-8 bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <header class="border-b border-gray-100 dark:border-gray-700/60">
        <div class="w-full px-5 pt-4 flex justify-between">
          <h2 class="font-semibold text-gray-800 dark:text-gray-100">Activité des utilisateurs</h2>
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
      <div class="p-3">
        <%!-- Table --%>
        <div class="overflow-x-auto">
          <table class="table-auto w-full">
            <%!-- Table header --%>
            <thead class="text-xs font-semibold uppercase text-gray-400 dark:text-gray-500 bg-gray-50 dark:bg-gray-700/50">
              <tr>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-left">Identité</div>
                </th>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-left">Email</div>
                </th>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-left">Statut</div>
                </th>
                <th class="p-2 whitespace-nowrap">
                  <div class="font-semibold text-center">Présent</div>
                </th>
              </tr>
            </thead>
            <%!-- Table body --%>
            <tbody class="text-sm divide-y divide-gray-100 dark:divide-gray-700/60">
              <%= for current_user <- @user_table do %>
                <tr
                  class="cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
                  phx-click={JS.push("user_modale", value: %{id: "4", user: current_user.id})}
                >
                  <td class="p-2 whitespace-nowrap">
                    <div class="flex items-center">
                      <div class="w-10 h-10 shrink-0 mr-2 sm:mr-3">
                        <%!-- <img class="rounded-full" src={customer.image} width="40" height="40" alt={customer.name} /> --%>
                      </div>
                      <div class="font-medium text-gray-800 dark:text-gray-100">
                        {current_user.lastname} {current_user.firstname}
                      </div>
                    </div>
                  </td>
                  <td class="p-2 whitespace-nowrap">
                    <div class="text-left">{current_user.email}</div>
                  </td>
                  <td class="p-2 whitespace-nowrap">
                    <div class="text-left text-center">
                      {if current_user.role, do: current_user.role.name_role, else: "Aucun rôle"}
                    </div>
                  </td>
                  <td class="p-2 whitespace-nowrap">
                    <%!-- <div class="text-lg text-center font-medium text-green-500"><%= current_user.present %></div> --%>
                  </td>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    """
  end
end
