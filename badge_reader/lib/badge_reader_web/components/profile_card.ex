defmodule BadgeReaderWeb.ProfileCard do
  use Phoenix.LiveComponent
  alias BadgeReader.Accounts.User
  alias BadgeReader.Accounts
  import BadgeReaderWeb.EditMenu

  def mount(socket) do

  end

  def profile_card_01(assigns) do
    ~H"""
    <div class="flex flex-col h-full bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="w-full px-5">
        <header class="flex justify-between items-start pt-4">
            <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">Votre Activiter</h2>
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

  def profile_card_02(assigns) do
    ~H"""
    <div class="flex flex-col h-full bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="w-full px-5">
        <header class="flex justify-between items-start pt-4">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">Vos informations</h2>
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
        <h3 class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-3">
        VOS INFORMATION PERSONNEL
        </h3>
        <div class="bg-white dark:bg-gray-800 border-gray-400 mb-5 overflow-hidden shadow rounded-lg border">
          <div class="border-t border-gray-200 px-4 py-5 sm:p-0">
            <.form
                    for={@form}
                    id="edit_user"
                    phx-submit="submit_user"
                    phx-change="validate_user"
                  >
              <dl class="sm:divide-y sm:divide-gray-200">
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Nom
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%=@current_user.lastname%>
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Prénom
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%=@current_user.firstname%>
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Addresse email
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%=@current_user.email%>
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Mot de passe
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    **********
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Rôle
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%= if @current_user.role, do: @current_user.role.name_role, else: "Aucun rôle" %>
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Badge
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%= if @current_user.badge, do: @current_user.badge.name_badge, else: "Badge non attribuer" %>
                  </dd>
                </div>
              </dl>
            </.form>
          </div>
        </div>

        <div class="flex justify-end">
          <button class="bg-yellow-300 text-gray-100 hover:bg-yellow-400 text-2xl rounded-sm h-9 w-24">Modifier</button>
        </div>
      </div>
    </div>
    """
  end

  def profile_card_03(assigns) do
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
