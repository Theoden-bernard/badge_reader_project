defmodule BadgeReaderWeb.UserLive do
  use BadgeReaderWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    temperature = 70
    current_user = socket.assigns.current_scope.user
    current_user = BadgeReader.Repo.preload(current_user, :role)

    {:ok,
    socket
    |> assign(:current_user, current_user)
    |> assign(:is_open, true)
    |> assign(:active_menu_id, nil)
    |> assign(:temperature, temperature)}
  end

  @impl true
  def handle_params(_params, url, socket) do
    path = URI.parse(url).path
    {:noreply, assign(socket, :current_path, path)}
  end

  @impl true
  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end

  @impl true
  def handle_info({:toggle_sidebar}, socket) do
    send_update(BadgeReaderWeb.Sidebar, id: "main-sidebar", toggle_sidebar: true)
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex h-screen overflow-hidden">

      <.live_component
          module={BadgeReaderWeb.Sidebar}
          id="main-sidebar"
          current_path={@current_path}
          variant="v2"
          current_user={@current_user}
      />

      <%!-- Content area --%>
      <div class="relative flex flex-col flex-1 overflow-y-auto overflow-x-hidden">

        <%!--  Site header --%>
        <.live_component
        module={BadgeReaderWeb.Header}
        id="main-header"
        current_path={@current_path}
        variant="v2"
        current_user={@current_user}
        />

        <main class="grow">
            <div class="px-4 sm:px-6 lg:px-8 py-8 w-full max-w-9xl mx-auto">

                <%!--  Dashboard actions --%>
                <div class="sm:flex sm:justify-between sm:items-center mb-8">

                    <%!--  Left: Title --%>
                    <div class="mb-4 sm:mb-0">
                        <h1 class="text-2xl md:text-3xl text-gray-800 dark:text-gray-100 font-bold">Utilisateur</h1>
                    </div>

                    <%!--  Right: Actions --%>
                    <div class="grid grid-flow-col sm:auto-cols-max justify-start sm:justify-end gap-2">

                        <%!-- FilterButton align="right" --%>

                        <%!-- Datepicker align="right" --%>

                        <%!--  Ajouter une vue button --%>
                        <button class="btn bg-gray-900 text-gray-100 hover:bg-gray-800 dark:bg-gray-100 dark:text-gray-800 dark:hover:bg-white">
                        <svg class="fill-current shrink-0 xs:hidden" width="16" height="16" viewBox="0 0 16 16">
                            <path d="M15 7H9V1c0-.6-.4-1-1-1S7 .4 7 1v6H1c-.6 0-1 .4-1 1s.4 1 1 1h6v6c0 .6.4 1 1 1s1-.4 1-1V9h6c.6 0 1-.4 1-1s-.4-1-1-1z" />
                        </svg>
                        <span class="max-xs:sr-only">Ajouter une vue</span>
                        </button>
                    </div>

                </div>

                <%!--  Cards --%>
              <div class="grid grid-cols-12 gap-6">

              </div>

              <div>
                <p>Current temperature: {@temperature}°F</p>
                <button phx-click="inc_temperature" class="bg-amber-400 w-10 h-10 relative z-50">
                  +
                </button>
              </div>

            </div>
        </main>

      </div>
    </div>
    """
  end
end
