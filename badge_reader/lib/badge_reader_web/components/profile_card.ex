defmodule BadgeReaderWeb.ProfileCard do
  @moduledoc """
  A LiveComponent container holding presentational interface cards for user profiles
  and personal metrics dashboards.

  This module groups together several reusable HEEx sub-components designed to display
  authenticated user data, weekly activity summaries, and related system events.

  ## Components

  * `profile_card_01/1`: Renders a placeholder card intended for embedding weekly activity or bar chart metrics.
  * `profile_card_02/1`: Renders an account information summary sheet inside a structural definition form loop, displaying fields such as names, email, assigned role, and badge status.
  * `profile_card_03/1`: Renders an operational placeholder card built to house personal chronological user events or audit logs.

  ## Features

  * **Declarative Configuration:** Uses `attr` definitions to supply structural toggle parameters directly to embedded submenus (`.edit_menu`).
  * **Unified Presentation Layer:** Streamlines presentation elements across back-office account screens or profile settings.

  ## Examples

  Rendering individual profile tracking wrappers inside a larger HEEx template block:

    <.live_component
      module={BadgeReaderWeb.ProfileCard}
      id="user-profile-cards"
    >
      <.profile_card_02
        current_user={@current_user}
        form={@form}
        is_open={@menu_open?}
        on_toggle="toggle_menu"
      />
    </.live_component>
  """

  use Phoenix.LiveComponent
  import BadgeReaderWeb.EditMenu

  attr :is_open, :boolean, default: false
  attr :on_toggle, :any, default: nil

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
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Vos informations
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
                    {@current_user.lastname}
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Prénom
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    {@current_user.firstname}
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Addresse email
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    {@current_user.email}
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
                    {if @current_user.role, do: @current_user.role.name_role, else: "Aucun rôle"}
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Badge
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    {if @current_user.badge,
                      do: @current_user.badge.name_badge,
                      else: "Badge non attribuer"}
                  </dd>
                </div>
              </dl>
            </.form>
          </div>
        </div>

        <div class="flex justify-end">
          <button class="bg-yellow-300 text-gray-100 hover:bg-yellow-400 text-2xl rounded-sm h-9 w-24">
            Modifier
          </button>
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
