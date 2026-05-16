defmodule BadgeReaderWeb.UserProfileLive do
  use BadgeReaderWeb, :live_view
  alias BadgeReader.Accounts

  @impl true
  def mount(%{"id" => id_user}, _session, socket) do
    user = Accounts.get_user!(id_user)
    user = BadgeReader.Repo.preload(user, :role)
    current_user = socket.assigns.current_scope.user
    current_user = BadgeReader.Repo.preload(current_user, :role)

    {:ok,
    socket
    |> assign(:user, user)
    |> assign(:current_user, current_user)}
  end

  @impl true
  def handle_params(_params, url, socket) do
    path = URI.parse(url).path
    {:noreply, assign(socket, :current_path, path)}
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
                  <div class="text-6xl"><%= if @user, do: "#{@user.lastname} #{@user.firstname}", else: "Non connecté" %></div>
                  <div class="text-2xl"><%= if @user, do: @user.role.name_role, else: "Aucun rôle" %></div>
              </div>
          </div>
            <%!-- Cards --%>
          <div class="px-4 sm:px-6 lg:px-8 py-8 grid grid-cols-12 gap-6 grid-rows-10">
          </div>
        </div>
      </div>
    """
  end
end
