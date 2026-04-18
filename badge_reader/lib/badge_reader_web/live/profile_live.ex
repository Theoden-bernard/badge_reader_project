defmodule BadgeReaderWeb.ProfileLive do
  use BadgeReaderWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    temperature = 70
    {:ok, assign(socket, :temperature, temperature)}
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
  def render(assigns) do
    ~H"""
     <div class="flex h-screen overflow-hidden">
        <.live_component
          module={BadgeReaderWeb.Sidebar}
          id="main-sidebar"
          current_path={@current_path}
          variant="v2"
        />

        <div class="relative flex flex-col flex-1 overflow-y-auto overflow-x-hidden">

          <.live_component
            module={BadgeReaderWeb.Header}
            id="main-header"
            current_path={@current_path}
            variant="v2"
          />

          <div class="flex flex-row mt-10">
              <img class="ml-10 mr-10 w-30 h-30 rounded-full" src="../images/img_users/user-avatar-32.png" width="25" height="25" alt="User" />
              <div class="flex flex-col">
                  <div class="text-6xl">Bernard Théoden</div>
                  <div class="text-2xl">Administrateur</div>
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
