defmodule BadgeReaderWeb.Header do
  use Phoenix.LiveComponent
  alias Phoenix.LiveView.JS

  @impl true
  def mount(socket) do
    {:ok,
     socket
     |> assign(:search_modal_open, false)
     |> assign(:notifications_open, false)
     |> assign(:help_open, false)
     |> assign(:user_menu_open, false)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("toggle_search_modal", _params, socket) do
    {:noreply, update(socket, :search_modal_open, &(!&1))}
  end

  def handle_event("close_search_modal", _params, socket) do
    {:noreply, assign(socket, :search_modal_open, false)}
  end

  def handle_event("toggle_notifications", _params, socket) do
    {:noreply,
     socket
     |> assign(:notifications_open, !socket.assigns.notifications_open)
     |> assign(:help_open, false)
     |> assign(:user_menu_open, false)}
  end

  def handle_event("toggle_help", _params, socket) do
    {:noreply,
     socket
     |> assign(:help_open, !socket.assigns.help_open)
     |> assign(:notifications_open, false)
     |> assign(:user_menu_open, false)}
  end

  def handle_event("toggle_user_menu", _params, socket) do
    {:noreply,
     socket
     |> assign(:user_menu_open, !socket.assigns.user_menu_open)
     |> assign(:notifications_open, false)
     |> assign(:help_open, false)}
  end

  def handle_event("close_all_dropdowns", _params, socket) do
    {:noreply,
     socket
     |> assign(:notifications_open, false)
     |> assign(:help_open, false)
     |> assign(:user_menu_open, false)}
  end

  def handle_event("toggle_sidebar", _params, socket) do
    # Envoyer l'événement au parent ou à la sidebar
    send(self(), {:toggle_sidebar})
    {:noreply, socket}
  end

  defp header_classes(variant) do
    base = "sticky top-0 before:absolute before:inset-0 before:backdrop-blur-md max-lg:before:bg-white/90 dark:max-lg:before:bg-gray-800/90 before:-z-10 z-30"

    variant_classes =
      case variant do
        "v2" ->
          "before:bg-white dark:before:bg-gray-800 after:absolute after:h-px after:inset-x-0 after:top-full after:bg-gray-200 dark:after:bg-gray-700/60 after:-z-10"

        "v3" ->
          "before:bg-white dark:before:bg-gray-900 after:absolute after:h-px after:inset-x-0 after:top-full after:bg-gray-200 dark:after:bg-gray-700/60 after:-z-10"

        _ ->
          "max-lg:shadow-xs lg:before:bg-gray-100/90 dark:lg:before:bg-gray-900/90"
      end

    "#{base} #{variant_classes}"
  end

  defp border_class(variant) when variant in ["v2", "v3"], do: ""
  defp border_class(_), do: "lg:border-b border-gray-200 dark:border-gray-700/60"

  @impl true
  def render(assigns) do
    ~H"""
    <header class={header_classes(@variant)} phx-click-away="close_all_dropdowns" phx-target={@myself}>
      <div class="px-4 sm:px-6 lg:px-8">
        <div class={["flex items-center justify-between h-16", border_class(@variant)]}>

          <%!-- Header: Left side --%>
          <div class="flex">
            <%!-- Hamburger button --%>
            <button
              class="text-gray-500 hover:text-gray-600 dark:hover:text-gray-400 lg:hidden"
              aria-controls="sidebar"
              phx-click="toggle_sidebar"
              phx-target={@myself}
            >
              <span class="sr-only">Open sidebar</span>
              <svg class="w-6 h-6 fill-current" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <rect x="4" y="5" width="16" height="2" />
                <rect x="4" y="11" width="16" height="2" />
                <rect x="4" y="17" width="16" height="2" />
              </svg>
            </button>
          </div>

          <%!-- Header: Right side --%>
          <div class="flex items-center space-x-3">

            <%!-- Search button --%>
            <div>
              <button
                class={[
                  "w-8 h-8 flex items-center justify-center hover:bg-gray-100 lg:hover:bg-gray-200 dark:hover:bg-gray-700/50 dark:lg:hover:bg-gray-800 rounded-full ml-3",
                  @search_modal_open && "bg-gray-200 dark:bg-gray-800"
                ]}
                phx-click="toggle_search_modal"
                phx-target={@myself}
                aria-controls="search-modal"
              >
                <span class="sr-only">Search</span>
                <svg
                  class="fill-current text-gray-500/80 dark:text-gray-400/80"
                  width={16}
                  height={16}
                  viewBox="0 0 16 16"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M7 14c-3.86 0-7-3.14-7-7s3.14-7 7-7 7 3.14 7 7-3.14 7-7 7ZM7 2C4.243 2 2 4.243 2 7s2.243 5 5 5 5-2.243 5-5-2.243-5-5-5Z" />
                  <path d="m13.314 11.9 2.393 2.393a.999.999 0 1 1-1.414 1.414L11.9 13.314a8.019 8.019 0 0 0 1.414-1.414Z" />
                </svg>
              </button>

              <%!-- Search Modal --%>
              <%= if @search_modal_open do %>
                <div
                  class="fixed inset-0 bg-gray-900/30 z-50 transition-opacity"
                  phx-click="close_search_modal"
                  phx-target={@myself}
                >
                  <div
                    class="relative max-w-2xl mx-auto mt-20"
                    phx-click="close_search_modal"
                    phx-target={@myself}
                  >
                    <div
                      class="bg-white dark:bg-gray-800 rounded-lg shadow-lg"
                      phx-click={JS.exec("phx-remove", to: "nothing")}
                    >
                      <form class="border-b border-gray-200 dark:border-gray-700/60">
                        <div class="flex items-center">
                          <svg
                            class="shrink-0 fill-current text-gray-400 dark:text-gray-500 ml-4"
                            width="16"
                            height="16"
                            viewBox="0 0 16 16"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path d="M7 14c-3.86 0-7-3.14-7-7s3.14-7 7-7 7 3.14 7 7-3.14 7-7 7ZM7 2C4.243 2 2 4.243 2 7s2.243 5 5 5 5-2.243 5-5-2.243-5-5-5Z" />
                            <path d="m13.314 11.9 2.393 2.393a.999.999 0 1 1-1.414 1.414L11.9 13.314a8.019 8.019 0 0 0 1.414-1.414Z" />
                          </svg>
                          <input
                            id="search"
                            class="w-full dark:text-gray-300 bg-white dark:bg-gray-800 border-0 focus:ring-transparent placeholder-gray-400 dark:placeholder-gray-500 appearance-none py-3 pl-2 pr-4"
                            type="search"
                            placeholder="Rechercher..."
                            autofocus
                          />
                        </div>
                      </form>
                      <div class="py-4 px-2">
                        <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase px-2 mb-2">
                          Résultats récents
                        </div>
                        <p class="text-sm text-gray-500 dark:text-gray-400 px-2 py-3">
                          Aucun résultat récent
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>

            <%!-- Notifications Dropdown --%>
            <div class="relative inline-flex">
              <button
                class={[
                  "w-8 h-8 flex items-center justify-center hover:bg-gray-100 lg:hover:bg-gray-200 dark:hover:bg-gray-700/50 dark:lg:hover:bg-gray-800 rounded-full",
                  @notifications_open && "bg-gray-200 dark:bg-gray-800"
                ]}
                phx-click="toggle_notifications"
                phx-target={@myself}
                aria-haspopup="true"
                aria-expanded={@notifications_open}
              >
                <span class="sr-only">Notifications</span>
                <svg
                  class="fill-current text-gray-500/80 dark:text-gray-400/80"
                  width="16"
                  height="16"
                  viewBox="0 0 16 16"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M6.5 0C2.91 0 0 2.462 0 5.5c0 1.075.37 2.074 1 2.922V12l2.699-1.542A7.454 7.454 0 0 0 6.5 11c3.59 0 6.5-2.462 6.5-5.5S10.09 0 6.5 0Z" />
                  <path d="M16 9.5c0-.987-.429-1.897-1.147-2.639C14.124 10.348 10.66 13 6.5 13c-.103 0-.202-.018-.305-.021C7.231 13.617 8.556 14 10 14c.449 0 .886-.04 1.307-.11L15 16v-4h-.012C15.627 11.285 16 10.425 16 9.5Z" />
                </svg>
                <div class="absolute top-0 right-0 w-2.5 h-2.5 bg-red-500 border-2 border-white dark:border-gray-800 rounded-full"></div>
              </button>

              <%= if @notifications_open do %>
                <div class="origin-top-right z-10 absolute top-full right-0 -mr-48 sm:mr-0 min-w-80 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700/60 py-1.5 rounded-lg shadow-lg overflow-hidden mt-1">
                  <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase pt-1.5 pb-2 px-3">
                    Notifications
                  </div>
                  <ul>
                    <li class="border-b border-gray-200 dark:border-gray-700/60 last:border-0">
                      <a
                        class="block py-2 px-3 hover:bg-gray-50 dark:hover:bg-gray-700/20"
                        href="#0"
                        phx-click="close_all_dropdowns"
                        phx-target={@myself}
                      >
                        <span class="block text-sm mb-2">
                          <span class="font-medium text-gray-800 dark:text-gray-100">
                            Exemple de notification
                          </span>
                        </span>
                        <span class="block text-xs text-gray-500">Il y a 2 minutes</span>
                      </a>
                    </li>
                  </ul>
                </div>
              <% end %>
            </div>

            <%!-- Help Dropdown --%>
            <div class="relative inline-flex">
              <button
                class={[
                  "w-8 h-8 flex items-center justify-center hover:bg-gray-100 lg:hover:bg-gray-200 dark:hover:bg-gray-700/50 dark:lg:hover:bg-gray-800 rounded-full",
                  @help_open && "bg-gray-200 dark:bg-gray-800"
                ]}
                phx-click="toggle_help"
                phx-target={@myself}
                aria-haspopup="true"
                aria-expanded={@help_open}
              >
                <span class="sr-only">Aide</span>
                <svg
                  class="fill-current text-gray-500/80 dark:text-gray-400/80"
                  width="16"
                  height="16"
                  viewBox="0 0 16 16"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M8 0C3.6 0 0 3.6 0 8s3.6 8 8 8 8-3.6 8-8-3.6-8-8-8Zm0 12c-.6 0-1-.4-1-1s.4-1 1-1 1 .4 1 1-.4 1-1 1Zm1-3H7V4h2v5Z" />
                </svg>
              </button>

              <%= if @help_open do %>
                <div class="origin-top-right z-10 absolute top-full right-0 min-w-44 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700/60 py-1.5 rounded-lg shadow-lg overflow-hidden mt-1">
                  <div class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase pt-1.5 pb-2 px-3">
                    Besoin d'aide ?
                  </div>
                  <ul>
                    <li>
                      <a
                        class="font-medium text-sm text-violet-500 hover:text-violet-600 dark:hover:text-violet-400 flex items-center py-1 px-3"
                        href="#0"
                        phx-click="close_all_dropdowns"
                        phx-target={@myself}
                      >
                        <svg
                          class="fill-current text-violet-500 shrink-0 mr-2"
                          width="12"
                          height="12"
                          viewBox="0 0 12 12"
                        >
                          <rect y="3" width="12" height="9" rx="1" />
                          <path d="M2 0h8v2H2z" />
                        </svg>
                        <span>Documentation</span>
                      </a>
                    </li>
                    <li>
                      <a
                        class="font-medium text-sm text-violet-500 hover:text-violet-600 dark:hover:text-violet-400 flex items-center py-1 px-3"
                        href="#0"
                        phx-click="close_all_dropdowns"
                        phx-target={@myself}
                      >
                        <svg
                          class="fill-current text-violet-500 shrink-0 mr-2"
                          width="12"
                          height="12"
                          viewBox="0 0 12 12"
                        >
                          <path d="M10.5 0h-9A1.5 1.5 0 0 0 0 1.5v9A1.5 1.5 0 0 0 1.5 12h9a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 10.5 0ZM10 7L8.207 5.207l-3 3-1.414-1.414 3-3L5 2h5v5Z" />
                        </svg>
                        <span>Support</span>
                      </a>
                    </li>
                  </ul>
                </div>
              <% end %>
            </div>

            <%!-- Theme Toggle --%>
            <div>
              <input
                type="checkbox"
                name="light-switch"
                id="light-switch"
                class="light-switch sr-only"
                phx-hook="ThemeToggle"
              />
              <label
                class="flex items-center justify-center cursor-pointer w-8 h-8 hover:bg-gray-100 lg:hover:bg-gray-200 dark:hover:bg-gray-700/50 dark:lg:hover:bg-gray-800 rounded-full"
                for="light-switch"
              >
                <svg
                  class="dark:hidden fill-current text-gray-500/80 dark:text-gray-400/80"
                  width={16}
                  height={16}
                  viewBox="0 0 16 16"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M8 0a1 1 0 0 1 1 1v.5a1 1 0 1 1-2 0V1a1 1 0 0 1 1-1Z" />
                  <path d="M12 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0Zm-4 2a2 2 0 1 0 0-4 2 2 0 0 0 0 4Z" />
                  <path d="M13.657 3.757a1 1 0 0 0-1.414-1.414l-.354.354a1 1 0 0 0 1.414 1.414l.354-.354ZM13.5 8a1 1 0 0 1 1-1h.5a1 1 0 1 1 0 2h-.5a1 1 0 0 1-1-1ZM13.303 11.889a1 1 0 0 0-1.414 1.414l.354.354a1 1 0 0 0 1.414-1.414l-.354-.354ZM8 13.5a1 1 0 0 1 1 1v.5a1 1 0 1 1-2 0v-.5a1 1 0 0 1 1-1ZM4.111 13.303a1 1 0 1 0-1.414-1.414l-.354.354a1 1 0 1 0 1.414 1.414l.354-.354ZM0 8a1 1 0 0 1 1-1h.5a1 1 0 0 1 0 2H1a1 1 0 0 1-1-1ZM3.757 2.343a1 1 0 1 0-1.414 1.414l.354.354A1 1 0 1 0 4.11 2.697l-.354-.354Z" />
                </svg>
                <svg
                  class="hidden dark:block fill-current text-gray-500/80 dark:text-gray-400/80"
                  width={16}
                  height={16}
                  viewBox="0 0 16 16"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M11.875 4.375a.625.625 0 1 0 1.25 0c.001-.69.56-1.249 1.25-1.25a.625.625 0 1 0 0-1.25 1.252 1.252 0 0 1-1.25-1.25.625.625 0 1 0-1.25 0 1.252 1.252 0 0 1-1.25 1.25.625.625 0 1 0 0 1.25c.69.001 1.249.56 1.25 1.25Z" />
                  <path d="M7.019 1.985a1.55 1.55 0 0 0-.483-1.36 1.44 1.44 0 0 0-1.53-.277C2.056 1.553 0 4.5 0 7.9 0 12.352 3.648 16 8.1 16c3.407 0 6.246-2.058 7.51-4.963a1.446 1.446 0 0 0-.25-1.55 1.554 1.554 0 0 0-1.372-.502c-4.01.552-7.539-2.987-6.97-7ZM2 7.9C2 5.64 3.193 3.664 4.961 2.6 4.82 7.245 8.72 11.158 13.36 11.04 12.265 12.822 10.341 14 8.1 14 4.752 14 2 11.248 2 7.9Z" />
                </svg>
                <span class="sr-only">Switch to light / dark version</span>
              </label>
            </div>

            <%!-- Divider --%>
            <hr class="w-px h-6 bg-gray-200 dark:bg-gray-700/60 border-none" />

            <%!-- User Menu --%>
            <div class="relative inline-flex">
              <button
                class={[
                  "inline-flex justify-center items-center group",
                  @user_menu_open && "bg-gray-200 dark:bg-gray-800"
                ]}
                phx-click="toggle_user_menu"
                phx-target={@myself}
                aria-haspopup="true"
                aria-expanded={@user_menu_open}
              >
                <img
                  class="w-8 h-8 rounded-full"
                  src="https://ui-avatars.com/api/?name=User&background=8b5cf6&color=fff"
                  width="32"
                  height="32"
                  alt="User"
                />
                <div class="flex items-center truncate">
                  <span class="truncate ml-2 text-sm font-medium text-gray-600 dark:text-gray-100 group-hover:text-gray-800 dark:group-hover:text-white">
                    Utilisateur
                  </span>
                  <svg
                    class="w-3 h-3 shrink-0 ml-1 fill-current text-gray-400 dark:text-gray-500"
                    viewBox="0 0 12 12"
                  >
                    <path d="M5.9 11.4L.5 6l1.4-1.4 4 4 4-4L11.3 6z" />
                  </svg>
                </div>
              </button>

              <%= if @user_menu_open do %>
                <div class="origin-top-right z-10 absolute top-full right-0 min-w-44 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700/60 py-1.5 rounded-lg shadow-lg overflow-hidden mt-1">
                  <div class="pt-0.5 pb-2 px-3 mb-1 border-b border-gray-200 dark:border-gray-700/60">
                    <div class="font-medium text-gray-800 dark:text-gray-100">Utilisateur</div>
                    <div class="text-xs text-gray-500 dark:text-gray-400 italic">Administrateur</div>
                  </div>
                  <ul>
                    <li>
                      <.link
                        navigate="/profile"
                        class="font-medium text-sm text-violet-500 hover:text-violet-600 dark:hover:text-violet-400 flex items-center py-1 px-3"
                        phx-click="close_all_dropdowns"
                        phx-target={@myself}
                      >
                        Paramètres
                      </.link>
                    </li>
                    <li>
                      <a
                        class="font-medium text-sm text-violet-500 hover:text-violet-600 dark:hover:text-violet-400 flex items-center py-1 px-3"
                        href="/logout"
                        phx-click="close_all_dropdowns"
                        phx-target={@myself}
                      >
                        Se déconnecter
                      </a>
                    </li>
                  </ul>
                </div>
              <% end %>
            </div>

          </div>

        </div>
      </div>
    </header>
    """
  end
end
