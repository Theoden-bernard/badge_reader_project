defmodule BadgeReaderWeb.Sidebar do
  use Phoenix.LiveComponent

  @impl true
  def mount(socket) do
    {:ok,
     socket
     |> assign(:sidebar_open, false)
     |> assign(:sidebar_expanded, false)
     |> assign(:open_groups, %{})}
  end

  @impl true
  def update(%{toggle_sidebar: true} = assigns, socket) do
    {:ok,
    socket
    |> assign(assigns)
    |> update(:sidebar_open, &(!&1))}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("toggle_sidebar", _params, socket) do
    {:noreply, update(socket, :sidebar_open, &(!&1))}
  end

  def handle_event("toggle_sidebar_expanded", _params, socket) do
    {:noreply, update(socket, :sidebar_expanded, &(!&1))}
  end

  def handle_event("toggle_group", %{"group" => group}, socket) do
    groups = socket.assigns.open_groups
    updated = Map.update(groups, group, true, &(!&1))
    {:noreply, assign(socket, :open_groups, updated)}
  end

  # defp group_open?(open_groups, group), do: Map.get(open_groups, group, false)

  defp sidebar_translate(true), do: "translate-x-0"
  defp sidebar_translate(false), do: "-translate-x-64"

  defp active_link_class(current_path, path) do
    if String.starts_with?(current_path, path) or current_path == path do
      "ml-4 text-yellow-500"
    else
      "ml-4 text-gray-500/90 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200"
    end
  end

  defp active_icon_class(current_path, segment) do
    if String.contains?(current_path, segment) do
      "text-yellow-500"
    else
      "text-gray-400 dark:text-gray-500"
    end
  end

  attr :active_condition, :boolean, default: false
  attr :group_id, :string, required: true
  attr :open_groups, :map, required: true
  attr :target, :any, required: true
  slot :content, required: true

  def sidebar_link_group(assigns) do
    ~H"""
    <li class={[
      "pl-4 pr-3 py-2 rounded-lg mb-0.5 last:mb-0 bg-linear-to-r",
      @active_condition && "from-yellow-500/[0.12] dark:from-yellow-500/[0.24] to-yellow-500/[0.04]" ]}>
      <%= render_slot(@content, %{ toggle: "toggle_group", is_open: Map.get(@open_groups, @group_id, @active_condition) }) %>
    </li>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div class={["min-w-fit", if(@sidebar_expanded, do: "sidebar-expanded", else: "")]}>

        <%!-- Backdrop mobile --%>
        <div
          class={[
            "fixed inset-0 bg-gray-900/30 z-40 lg:hidden lg:z-auto transition-opacity duration-200",
            if(@sidebar_open, do: "opacity-100", else: "opacity-0 pointer-events-none")
          ]}
          aria-hidden="true"
        />

        <%!-- Sidebar --%>
        <div
          id="sidebar"
          class={[
            "flex lg:flex! flex-col absolute z-40 left-0 top-0",
            "lg:static lg:left-auto lg:top-auto lg:translate-x-0",
            "h-[100dvh] overflow-x-hidden overflow-y-auto no-scrollbar",
            "w-64 lg:w-20 lg:sidebar-expanded:!w-64 2xl:w-64! shrink-0",
            "bg-white dark:bg-gray-800 p-4 transition-all duration-200 ease-in-out",

            sidebar_translate(@sidebar_open),
            if(@variant == "v2",
              do: "border-r border-gray-200 dark:border-gray-700/60",
              else: "rounded-r-2xl shadow-xs"
            )
          ]}
        >

          <%!-- Header sidebar --%>
          <div class="flex justify-between mb-10 pr-3 sm:px-2">
            <button
              class="lg:hidden text-gray-500 hover:text-gray-400"
              phx-click="toggle_sidebar"
              phx-target={@myself}
              aria-controls="sidebar"
              aria-expanded={@sidebar_open}
            >
              <span class="sr-only">Fermer la barre latérale</span>
              <svg class="w-6 h-6 fill-current" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M10.7 18.7l1.4-1.4L7.8 13H20v-2H7.8l4.3-4.3-1.4-1.4L4 12z" />
              </svg>
            </button>

            <.link navigate="/users/dashboard" class="block">
              <svg class="fill-yellow-500" xmlns="http://www.w3.org/2000/svg" width={32} height={32}>
                <path d="M31.956 14.8C31.372 6.92 25.08.628 17.2.044V5.76a9.04 9.04 0 0 0 9.04 9.04h5.716ZM14.8 26.24v5.716C6.92 31.372.63 25.08.044 17.2H5.76a9.04 9.04 0 0 1 9.04 9.04Zm11.44-9.04h5.716c-.584 7.88-6.876 14.172-14.756 14.756V26.24a9.04 9.04 0 0 1 9.04-9.04ZM.044 14.8C.63 6.92 6.92.628 14.8.044V5.76a9.04 9.04 0 0 1-9.04 9.04H.044Z" />
              </svg>
            </.link>
          </div>

          <%!-- Navigation --%>
          <div class="space-y-8">

            <%!-- Groupe principal --%>
            <div>
              <h3 class="text-xs uppercase text-gray-400 dark:text-gray-500 font-semibold pl-3">
                <span class="hidden lg:block lg:sidebar-expanded:hidden 2xl:hidden text-center w-6" aria-hidden="true">•••</span>
                <span class="lg:hidden lg:sidebar-expanded:block 2xl:block">Pages principales</span>
              </h3>

              <ul class="mt-3">

                <%!-- Dashboard --%>
                 <.sidebar_link_group
                  group_id="dashboard"
                  active_condition={String.contains?(@current_path, "dashboard")}
                  open_groups={@open_groups}
                  target={@myself}
                >
                  <:content :let={%{is_open: _is_open}}>
                    <div class="flex items-center">
                      <.link navigate="/users/dashboard">
                        <svg
                          class={["shrink-0 fill-current", active_icon_class(@current_path, "dashboard")]}
                          xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                        >
                          <path d="M5.936.278A7.983 7.983 0 0 1 8 0a8 8 0 1 1-8 8c0-.722.104-1.413.278-2.064a1 1 0 1 1 1.932.516A5.99 5.99 0 0 0 2 8a6 6 0 1 0 6-6c-.53 0-1.045.076-1.548.21A1 1 0 1 1 5.936.278Z" />
                          <path d="M6.068 7.482A2.003 2.003 0 0 0 8 10a2 2 0 1 0-.518-3.932L3.707 2.293a1 1 0 0 0-1.414 1.414l3.775 3.775Z" />
                        </svg>
                      </.link>
                      <.link
                        navigate="/users/dashboard"
                        class={["block transition duration-150 truncate", active_link_class(@current_path, "/dashboard")]}
                      >
                        <span class="text-sm font-medium lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                          Dashboard - <%= if @current_user, do: @current_user.firstname, else: "Non connecté" %>
                        </span>
                      </.link>
                    </div>
                  </:content>
                </.sidebar_link_group>

                <%!-- Utilisateur (avec sous-menu) --%>
                <.sidebar_link_group
                  group_id="utilisateur"
                  active_condition={String.contains?(@current_path, "utilisateur")}
                  open_groups={@open_groups}
                  target={@myself}
                >
                  <:content :let={%{is_open: is_open}}>
                    <div
                      class="flex items-center justify-between cursor-pointer"
                      phx-click="toggle_group"
                      phx-value-group="utilisateur"
                      phx-target={@myself}
                    >
                      <div class="flex items-center">
                        <.link navigate="/users/utilisateur">
                          <svg
                            class={["shrink-0 fill-current", active_icon_class(@current_path, "utilisateur")]}
                            xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                          >
                            <path d="M12 1a1 1 0 1 0-2 0v2a3 3 0 0 0 3 3h2a1 1 0 1 0 0-2h-2a1 1 0 0 1-1-1V1ZM1 10a1 1 0 1 0 0 2h2a1 1 0 0 1 1 1v2a1 1 0 1 0 2 0v-2a3 3 0 0 0-3-3H1ZM5 0a1 1 0 0 1 1 1v2a3 3 0 0 1-3 3H1a1 1 0 0 1 0-2h2a1 1 0 0 0 1-1V1a1 1 0 0 1 1-1ZM12 13a1 1 0 0 1 1-1h2a1 1 0 1 0 0-2h-2a3 3 0 0 0-3 3v2a1 1 0 1 0 2 0v-2Z" />
                          </svg>
                        </.link>
                        <.link
                          navigate="/users/utilisateur"
                          class={["block transition duration-150 truncate", active_link_class(@current_path, "/utilisateur")]}
                        >
                          <span class="text-sm font-medium lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                            Utilisateur
                          </span>
                        </.link>
                      </div>
                      <div class="flex shrink-0 ml-2">
                        <svg
                          class={["w-3 h-3 shrink-0 ml-1 fill-current text-gray-400 dark:text-gray-500 transition-transform",
                            if(is_open, do: "rotate-180", else: "")
                          ]}
                          viewBox="0 0 12 12"
                        >
                          <path d="M5.9 11.4L.5 6l1.4-1.4 4 4 4-4L11.3 6z" />
                        </svg>
                      </div>
                    </div>
                    <div class="lg:hidden lg:sidebar-expanded:block 2xl:block">
                      <ul class={["pl-8 mt-1", if(is_open, do: "block", else: "hidden")]}>
                        <li class="mb-1 last:mb-0">
                          <button phx-click="trigger_modale" class="block transition duration-150 truncate">
                            Création
                          </button>
                        </li>
                        <li class="mb-1 last:mb-0">
                          <.link navigate="/modaleUtilisateurEdit"
                            class={["block transition duration-150 truncate", active_link_class(@current_path, "/modaleUtilisateurEdit")]}
                          >Modifications</.link>
                        </li>
                        <li class="mb-1 last:mb-0">
                          <.link navigate="/modaleUtilisateurDelete"
                            class={["block transition duration-150 truncate", active_link_class(@current_path, "/modaleUtilisateurDelete")]}
                          >Supprimer</.link>
                        </li>
                      </ul>
                    </div>
                  </:content>
                </.sidebar_link_group>

                <%!-- Badge (avec sous-menu) --%>
                <.sidebar_link_group
                  group_id="badge"
                  active_condition={String.contains?(@current_path, "badge")}
                  open_groups={@open_groups}
                  target={@myself}
                >
                  <:content :let={%{is_open: is_open}}>

                    <div
                      class="flex items-center justify-between cursor-pointer"
                      phx-click="toggle_group"
                      phx-value-group="badge"
                      phx-target={@myself}
                    >
                      <div class="flex items-center">
                        <.link navigate="/users/badge">
                          <svg
                            class={["shrink-0 fill-current", active_icon_class(@current_path, "badge")]}
                            xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                          >
                            <path d="M6 0a6 6 0 0 0-6 6c0 1.077.304 2.062.78 2.912a1 1 0 1 0 1.745-.976A3.945 3.945 0 0 1 2 6a4 4 0 0 1 4-4c.693 0 1.344.194 1.936.525A1 1 0 1 0 8.912.779 5.944 5.944 0 0 0 6 0Z" />
                            <path d="M10 4a6 6 0 1 0 0 12 6 6 0 0 0 0-12Zm-4 6a4 4 0 1 1 8 0 4 4 0 0 1-8 0Z" />
                          </svg>
                        </.link>
                        <.link
                          navigate="/users/badge"
                          class={["block transition duration-150 truncate", active_link_class(@current_path, "/badge")]}
                        >
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                            Badge
                          </span>
                        </.link>
                      </div>
                      <div class="flex shrink-0 ml-2">
                        <svg
                          class={["w-3 h-3 shrink-0 ml-1 fill-current text-gray-400 dark:text-gray-500 transition-transform",
                            if(is_open, do: "rotate-180", else: "")
                          ]}
                          viewBox="0 0 12 12"
                        >
                          <path d="M5.9 11.4L.5 6l1.4-1.4 4 4 4-4L11.3 6z" />
                        </svg>
                      </div>
                    </div>
                    <div class="lg:hidden lg:sidebar-expanded:block 2xl:block">
                      <ul class={["pl-8 mt-1", if(is_open, do: "block", else: "hidden")]}>
                        <li class="mb-1 last:mb-0">
                          <.link navigate="/modaleCreation"
                            class={["block transition duration-150 truncate", active_link_class(@current_path, "/modaleCreation")]}
                          >Création</.link>
                        </li>
                        <li class="mb-1 last:mb-0">
                          <.link navigate="/modaleEdit"
                            class={["block transition duration-150 truncate", active_link_class(@current_path, "/modaleEdit")]}
                          >Modifications</.link>
                        </li>
                        <li class="mb-1 last:mb-0">
                          <.link navigate="/modaleDelete"
                            class={["block transition duration-150 truncate", active_link_class(@current_path, "/modaleDelete")]}
                          >Supprimer</.link>
                        </li>
                      </ul>
                    </div>
                  </:content>
                </.sidebar_link_group>

                <%!-- Paramètres (avec sous-menu) --%>
                <.sidebar_link_group
                  group_id="settings"
                  active_condition={String.contains?(@current_path, "parametre")}
                  open_groups={@open_groups}
                  target={@myself}
                >
                  <:content :let={%{is_open: is_open}}>
                    <div
                      class="flex items-center justify-between cursor-pointer"
                      phx-click="toggle_group"
                      phx-value-group="settings"
                      phx-target={@myself}
                    >
                      <div class="flex items-center">
                        <.link navigate="/users/parametre">
                          <svg
                            class={["shrink-0 fill-current", active_icon_class(@current_path, "parametre")]}
                            xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                          >
                            <path d="M10.5 1a3.502 3.502 0 0 1 3.355 2.5H15a1 1 0 1 1 0 2h-1.145a3.502 3.502 0 0 1-6.71 0H1a1 1 0 0 1 0-2h6.145A3.502 3.502 0 0 1 10.5 1ZM9 4.5a1.5 1.5 0 1 1 3 0 1.5 1.5 0 0 1-3 0ZM5.5 9a3.502 3.502 0 0 1 3.355 2.5H15a1 1 0 1 1 0 2H8.855a3.502 3.502 0 0 1-6.71 0H1a1 1 0 1 1 0-2h1.145A3.502 3.502 0 0 1 5.5 9ZM4 12.5a1.5 1.5 0 1 0 3 0 1.5 1.5 0 0 0-3 0Z" fill-rule="evenodd" />
                          </svg>
                        </.link>
                        <.link
                          navigate="/users/parametre"
                          class={["block transition duration-150 truncate", active_link_class(@current_path, "/parametre")]}
                        >
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                            Paramètre
                          </span>
                        </.link>
                      </div>
                      <div class="flex shrink-0 ml-2">
                        <svg
                          class={["w-3 h-3 shrink-0 ml-1 fill-current text-gray-400 dark:text-gray-500 transition-transform",
                            if(is_open, do: "rotate-180", else: "")
                          ]}
                          viewBox="0 0 12 12"
                        >
                          <path d="M5.9 11.4L.5 6l1.4-1.4 4 4 4-4L11.3 6z" />
                        </svg>
                      </div>
                    </div>
                  <div class="lg:hidden lg:sidebar-expanded:block 2xl:block">
                    <ul class={["pl-8 mt-1", if(is_open, do: "block", else: "hidden")]}>
                      <li class="mb-1 last:mb-0">
                        <.link navigate="/users/profile"
                          class={["block transition duration-150 truncate", active_link_class(@current_path, "/profile")]}
                        >
                          <span class="text-sm font-medium lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                            Mon compte
                          </span>
                        </.link>
                      </li>
                      <li class="mb-1 last:mb-0">
                        <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200 text-gray-500/90 dark:text-gray-400">
                          Mes Notifications
                        </span>
                      </li>
                    </ul>
                  </div>
                  </:content>
                </.sidebar_link_group>

              </ul>
            </div>

            <%!-- Groupe secondaire --%>
            <div>
              <h3 class="text-xs uppercase text-gray-400 dark:text-gray-500 font-semibold pl-3">
                <span class="hidden lg:block lg:sidebar-expanded:hidden 2xl:hidden text-center w-6" aria-hidden="true">•••</span>
                <span class="lg:hidden lg:sidebar-expanded:block 2xl:block">More</span>
              </h3>

              <ul class="mt-3">

                <%!-- Authentification --%>
                <.sidebar_link_group
                  group_id="utilisateur"
                  active_condition={String.contains?(@current_path, "authentification")}
                  open_groups={@open_groups}
                  target={@myself}
                >
                  <:content :let={%{is_open: is_open}}>
                    <div
                      class="flex items-center justify-between cursor-pointer"
                      phx-click="toggle_group"
                      phx-value-group="authentification"
                      phx-target={@myself}
                    >
                      <div class="flex items-center">
                        <.link navigate="/users/authentification">
                          <svg
                            class={["shrink-0 fill-current", active_icon_class(@current_path, "authentification")]}
                            xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                          >
                            <path d="M11.442 4.576a1 1 0 1 0-1.634-1.152L4.22 11.35 1.773 8.366A1 1 0 1 0 .227 9.634l3.281 4a1 1 0 0 0 1.59-.058l6.344-9ZM15.817 4.576a1 1 0 1 0-1.634-1.152l-5.609 7.957a1 1 0 0 0-1.347 1.453l.656.8a1 1 0 0 0 1.59-.058l6.344-9Z" />
                          </svg>
                        </.link>
                        <.link
                          navigate="/users/authentification"
                          class={["block transition duration-150 truncate", active_link_class(@current_path, "/authentification")]}
                        >
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                            Authentification
                          </span>
                        </.link>
                      </div>
                      <div class="flex shrink-0 ml-2">
                        <svg
                          class={["w-3 h-3 shrink-0 ml-1 fill-current text-gray-400 dark:text-gray-500 transition-transform",
                            if(is_open, do: "rotate-180", else: "")
                          ]}
                          viewBox="0 0 12 12"
                        >
                          <path d="M5.9 11.4L.5 6l1.4-1.4 4 4 4-4L11.3 6z" />
                        </svg>
                      </div>
                    </div>
                    <div class="lg:hidden lg:sidebar-expanded:block 2xl:block">
                      <ul class={["pl-8 mt-1", if(is_open, do: "block", else: "hidden")]}>
                        <li class="mb-1 last:mb-0">
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200 text-gray-500/90 dark:text-gray-400">
                            Sign in
                          </span>
                        </li>
                        <li class="mb-1 last:mb-0">
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200 text-gray-500/90 dark:text-gray-400">
                            Sign up
                          </span>
                        </li>
                        <li class="mb-1 last:mb-0">
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200 text-gray-500/90 dark:text-gray-400">
                            Reset Password
                          </span>
                        </li>
                      </ul>
                    </div>
                  </:content>
                </.sidebar_link_group>

                <%!-- Evenement --%>
                <.sidebar_link_group
                  group_id="evenement"
                  active_condition={String.contains?(@current_path, "evenement")}
                  open_groups={@open_groups}
                  target={@myself}
                >
                  <:content :let={%{is_open: is_open}}>
                    <div
                      class="flex items-center justify-between cursor-pointer"
                    phx-click="toggle_group"
                    phx-value-group="evenement"
                    phx-target={@myself}
                    >
                      <div class="flex items-center">
                        <.link navigate="/users/evenement">
                          <svg
                            class={["shrink-0 fill-current", active_icon_class(@current_path, "evenement")]}
                            xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                          >
                            <path d="M6.668.714a1 1 0 0 1-.673 1.244 6.014 6.014 0 0 0-4.037 4.037 1 1 0 1 1-1.916-.571A8.014 8.014 0 0 1 5.425.041a1 1 0 0 1 1.243.673ZM7.71 4.709a3 3 0 1 0 0 6 3 3 0 0 0 0-6ZM9.995.04a1 1 0 1 0-.57 1.918 6.014 6.014 0 0 1 4.036 4.037 1 1 0 0 0 1.917-.571A8.014 8.014 0 0 0 9.995.041ZM14.705 8.75a1 1 0 0 1 .673 1.244 8.014 8.014 0 0 1-5.383 5.384 1 1 0 0 1-.57-1.917 6.014 6.014 0 0 0 4.036-4.037 1 1 0 0 1 1.244-.673ZM1.958 9.424a1 1 0 0 0-1.916.57 8.014 8.014 0 0 0 5.383 5.384 1 1 0 0 0 .57-1.917 6.014 6.014 0 0 1-4.037-4.037Z" />
                          </svg>
                        </.link>
                        <.link
                        navigate="/users/evenement"
                        class={["block transition duration-150 truncate", active_link_class(@current_path, "/evenement")]}
                        >
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                            Évènement
                          </span>
                        </.link>
                      </div>
                      <div class="flex shrink-0 ml-2">
                        <svg
                          class={["w-3 h-3 shrink-0 ml-1 fill-current text-gray-400 dark:text-gray-500 transition-transform",
                            if(is_open, do: "rotate-180", else: "")
                          ]}
                          viewBox="0 0 12 12"
                        >
                          <path d="M5.9 11.4L.5 6l1.4-1.4 4 4 4-4L11.3 6z" />
                        </svg>
                      </div>
                    </div>
                    <div class="lg:hidden lg:sidebar-expanded:block 2xl:block">
                      <ul class={["pl-8 mt-1", if(is_open, do: "block", else: "hidden")]}>
                        <%= for step <- ["Step 1", "Step 2", "Step 3", "Step 4"] do %>
                          <li class="mb-1 last:mb-0">
                            <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200 text-gray-500/90 dark:text-gray-400">
                              <%= step %>
                            </span>
                          </li>
                        <% end %>
                      </ul>
                    </div>
                  </:content>
                </.sidebar_link_group>

                <%!-- Composants --%>
                <.sidebar_link_group
                  group_id="composants"
                  active_condition={String.contains?(@current_path, "composants")}
                  open_groups={@open_groups}
                  target={@myself}
                >
                  <:content :let={%{is_open: is_open}}>
                    <div
                      class="flex items-center justify-between cursor-pointer"
                      phx-click="toggle_group"
                      phx-value-group="composants"
                      phx-target={@myself}
                    >
                      <div class="flex items-center">
                        <.link navigate="/users/composants">
                          <svg
                            class={["shrink-0 fill-current", active_icon_class(@current_path, "composants")]}
                            xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                          >
                            <path d="M.06 10.003a1 1 0 0 1 1.948.455c-.019.08.01.152.078.19l5.83 3.333c.053.03.116.03.168 0l5.83-3.333a.163.163 0 0 0 .078-.188 1 1 0 0 1 1.947-.459 2.161 2.161 0 0 1-1.032 2.384l-5.83 3.331a2.168 2.168 0 0 1-2.154 0l-5.83-3.331a2.162 2.162 0 0 1-1.032-2.382Zm7.856-7.981-5.83 3.332a.17.17 0 0 0 0 .295l5.828 3.33c.054.031.118.031.17.002l5.83-3.333a.17.17 0 0 0 0-.294L8.085 2.023a.172.172 0 0 0-.17-.001ZM9.076.285l5.83 3.332c1.458.833 1.458 2.935 0 3.768l-5.83 3.333c-.667.38-1.485.38-2.153-.001l-5.83-3.332c-1.457-.833-1.457-2.935 0-3.767L6.925.285a2.173 2.173 0 0 1 2.15 0Z" />
                          </svg>
                        </.link>
                        <.link
                          navigate="/users/composants"
                          class={["block transition duration-150 truncate", active_link_class(@current_path, "/composants")]}
                        >
                          <span class="text-sm font-medium ml-4 lg:opacity-0 lg:sidebar-expanded:opacity-100 2xl:opacity-100 duration-200">
                            Composants
                          </span>
                        </.link>
                      </div>
                      <div class="flex shrink-0 ml-2">
                        <svg
                          class={["w-3 h-3 shrink-0 ml-1 fill-current text-gray-400 dark:text-gray-500 transition-transform",
                            if(is_open, do: "rotate-180", else: "")
                          ]}
                          viewBox="0 0 12 12"
                        >
                          <path d="M5.9 11.4L.5 6l1.4-1.4 4 4 4-4L11.3 6z" />
                        </svg>
                      </div>
                    </div>
                    <div class="lg:hidden lg:sidebar-expanded:block 2xl:block">
                      <ul class={["pl-8 mt-1", if(is_open, do: "block", else: "hidden")]}>
                      </ul>
                    </div>
                  </:content>
                </.sidebar_link_group>
              </ul>
            </div>
          </div>

          <%!-- Bouton expand / collapse (desktop uniquement) --%>
          <div class="pt-3 hidden lg:inline-flex 2xl:hidden justify-end mt-auto">
            <div class="w-12 pl-4 pr-3 py-2">
              <button
                class="text-gray-400 hover:text-gray-500 dark:text-gray-500 dark:hover:text-gray-400"
                phx-click="toggle_sidebar_expanded"
                phx-target={@myself}
              >
                <span class="sr-only">Expand / collapse sidebar</span>
                <svg
                  class={["shrink-0 fill-current text-gray-400 dark:text-gray-500 transition-transform",
                    if(@sidebar_expanded, do: "rotate-180", else: "")
                  ]}
                  xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                >
                  <path d="M15 16a1 1 0 0 1-1-1V1a1 1 0 1 1 2 0v14a1 1 0 0 1-1 1ZM8.586 7H1a1 1 0 1 0 0 2h7.586l-2.793 2.793a1 1 0 1 0 1.414 1.414l4.5-4.5A.997.997 0 0 0 12 8.01M11.924 7.617a.997.997 0 0 0-.217-.324l-4.5-4.5a1 1 0 0 0-1.414 1.414L8.586 7M12 7.99a.996.996 0 0 0-.076-.373Z" />
                </svg>
              </button>
            </div>
          </div>

        </div>
      </div>
    """
  end
end
