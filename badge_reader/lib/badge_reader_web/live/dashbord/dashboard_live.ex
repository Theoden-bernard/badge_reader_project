defmodule BadgeReaderWeb.DashboardLive do
    use BadgeReaderWeb, :live_view

    @customers [
      %{id: "0", image: "../images/img_users/user-36-05.jpg", name: "Alex Shatov", email: "alexshatov@gmail.com", status: "Administrateur", present: "🟢"},
      %{id: "1", image: "/images/img_users/user-36-06.jpg", name: "Philip Harbach", email: "philip.h@gmail.com", status: "Staff", present: "🔴"},
      %{id: "2", image: "/images/img_users/user-36-07.jpg", name: "Mirko Fisuk", email: "mirkofisuk@gmail.com", status: "Etudiant", present: "🔴"},
      %{id: "3", image: "/images/img_users/user-36-08.jpg", name: "Olga Semklo", email: "olga.s@cool.design", status: "Etudiant", present: "🟢"},
      %{id: "4", image: "/images/img_users/user-36-09.jpg", name: "Burak Long", email: "longburak@gmail.com", status: "Etudiant", present: "🟢"},
    ]

    @impl true
    def mount(_params, _session, socket) do
        current_user = socket.assigns.current_scope.user
        current_user = BadgeReader.Repo.preload(current_user, :role)

        {:ok,
        socket
        |> assign(:current_user, current_user)
        |> assign(:customers, @customers)
        |> assign(:is_open, true)
        |> assign(:active_menu_id, nil)}
        # |> assign(:my_chart, my_chart)}
    end

    @impl true
    def handle_params(_params, url, socket) do
        path = URI.parse(url).path
        {:noreply, assign(socket, :current_path, path)}
    end

    @impl true
    def handle_event("toggle_menu", %{"id" => id}, socket) do
        new_active_id = if socket.assigns.active_menu_id == id, do: nil, else: id

        {:noreply,
        socket
        |> assign(:is_open, !socket.assigns.is_open)
        |> assign(:active_menu_id, new_active_id)}
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
                            <h1 class="text-2xl md:text-3xl text-gray-800 dark:text-gray-100 font-bold">Dashboard</h1>
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

                        <.live_component
                            id="card__dashboard_01"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard01}
                            is_open={@active_menu_id == "1"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "1"})}
                        />

                        <.live_component
                            id="card__dashboard_02"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard02}
                            is_open={@active_menu_id == "2"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "2"})}
                        />

                        <.live_component
                            id="card__dashboard_03"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard03}
                            is_open={@active_menu_id == "3"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "3"})}
                        />

                        <.live_component
                            id="card__dashboard_04"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard04}
                            is_open={@active_menu_id == "4"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "4"})}
                        />

                        <.live_component
                            id="live_enter"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard05}
                            is_open={@active_menu_id == "5"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "5"})}
                            entry_number={BadgeReader.Logs.count_logs_user_today()}
                        />

                        <.live_component
                            id="card__dashboard_06"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard06}
                            is_open={@active_menu_id == "6"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "6"})}
                        />

                        <.live_component
                            id="card__dashboard_07"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard07}
                            customers={@customers}
                            is_open={@active_menu_id == "7"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "7"})}
                        />

                        <.live_component
                            id="card__dashboard_08"
                            module={BadgeReaderWeb.Dashbord.ComponentsLive.DashbordCard08}
                            is_open={@active_menu_id == "8"}
                            on_toggle={JS.push("toggle_menu", value: %{id: "8"})}
                        />
                    </div>
                </div>
            </main>
        </div>
    </div>
    """
  end
end
