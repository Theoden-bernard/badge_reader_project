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
    {:ok,
     socket
     |> assign(:customers, @customers)
     |> assign(:is_open, true)
     |> assign(:active_menu_id, nil)}
  end

  @impl true
  def handle_params(_params, url, socket) do
    path = URI.parse(url).path
    {:noreply, assign(socket, :current_path, path)}
  end

  def handle_event("toggle_menu", %{"id" => id}, socket) do
    IO.inspect(socket.assigns.is_open)
    new_active_id = if socket.assigns.active_menu_id == id, do: nil, else: id

    {:noreply,
      socket
      |> assign(:is_open, !socket.assigns.is_open)
      |> assign(:active_menu_id, new_active_id)}
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
        />

        <%!-- Content area --%>
        <div class="relative flex flex-col flex-1 overflow-y-auto overflow-x-hidden">


            <%!--  Site header --%>
            <.live_component
            module={BadgeReaderWeb.Header}
            id="main-header"
            current_path={@current_path}
            variant="v2"
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
                        <div class="col-span-4 ">
                            <.dashboard_card_01
                                is_open={@active_menu_id == "1"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "1"})}
                            />
                        </div>

                        <div class="col-span-4 ">
                            <.dashboard_card_02
                                is_open={@active_menu_id == "2"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "2"})}
                            />
                        </div>

                        <div class="col-span-4 ">
                            <.dashboard_card_03
                                is_open={@active_menu_id == "3"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "3"})}
                            />
                        </div>

                        <div class="col-span-6 ">
                            <.dashboard_card_04
                                is_open={@active_menu_id == "4"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "4"})}
                            />
                        </div>

                        <div class="col-span-6 ">
                            <.dashboard_card_05
                                is_open={@active_menu_id == "5"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "5"})}
                            />
                        </div>

                        <div class="col-span-5 ">
                            <.dashboard_card_06
                                is_open={@active_menu_id == "6"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "6"})}
                            />
                        </div>

                        <div class="col-span-7 ">
                            <.dashboard_card_07
                                customers={@customers}
                                is_open={@active_menu_id == "7"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "7"})}
                            />
                        </div>

                        <div class="col-span-7 ">
                            <.dashboard_card_08
                                is_open={@active_menu_id == "8"}
                                on_toggle={JS.push("toggle_menu", value: %{id: "8"})}
                            />
                        </div>

                    </div>
                </div>
            </main>
        </div>
    </div>
    """
  end
end
