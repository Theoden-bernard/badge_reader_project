defmodule BadgeReaderWeb.ProfileLive do
  use BadgeReaderWeb, :live_view

@impl true
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_scope.user
    current_user = BadgeReader.Repo.preload(current_user, :role)
    current_user = BadgeReader.Repo.preload(current_user, :badge)

    {:ok,
    socket
    |> assign(:current_user, current_user)
    |> assign(:is_open, true)
    |> assign(:active_menu_id, nil)}
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

        <div class="relative flex flex-col flex-1 overflow-y-auto overflow-x-hidden">

          <.live_component
            module={BadgeReaderWeb.Header}
            id="main-header"
            current_path={@current_path}
            variant="v2"
            current_user={@current_user}
          />

          <div class="flex flex-row mt-10">
              <img class="ml-10 mr-10 w-30 h-30 rounded-full" src="../images/img_users/user-avatar-32.png" width="25" height="25" alt="User" />
              <div class="flex flex-col">
                  <div class="text-6xl"><%= if @current_user, do: "#{@current_user.lastname} #{@current_user.firstname}", else: "Non connecté" %></div>
                  <div class="text-2xl"><%= if @current_user, do: @current_user.role.name_role, else: "Aucun rôle" %></div>
              </div>
          </div>
            <%!-- Cards --%>
          <div class="px-4 sm:px-6 lg:px-8 py-8 grid grid-cols-12 gap-6 grid-rows-10">

            <div class="col-span-12 sm:col-span-8 xl:col-span-8 sm:row-span-5 xl:row-spen-5 h-full">
              <.live_component
                module={BadgeReaderWeb.Profile.ComponentsLive.ProfileCard01}
                id="activity_user"
                is_open={@active_menu_id == "1"}
                on_toggle={JS.push("toggle_menu", value: %{id: "1"})}
              />
            </div>

            <div class="col-span-12 sm:col-span-4 xl:col-span-4 sm:row-span-8 xl:row-spen-8 h-full">
              <.live_component
                module={BadgeReaderWeb.Profile.ComponentsLive.ProfileCard02}
                id="form_current_user"
                is_open={@active_menu_id == "2"}
                on_toggle={JS.push("toggle_menu", value: %{id: "2"})}
                current_user={@current_user}
              />
            </div>

            <div class="col-span-12 sm:col-span-8 xl:col-span-8 sm:row-span-3 xl:row-spen-3 h-full">
              <.live_component
                module={BadgeReaderWeb.Profile.ComponentsLive.ProfileCard03}
                id="event_user"
                is_open={@active_menu_id == "3"}
                on_toggle={JS.push("toggle_menu", value: %{id: "3"})}
              />
            </div>

          </div>
        </div>
      </div>
    """
  end
end
