defmodule BadgeReaderWeb.UserLive do
  use BadgeReaderWeb, :live_view
  alias BadgeReader.Accounts.User
  alias BadgeReader.Accounts

  @impl true
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_scope.user
    current_user = BadgeReader.Repo.preload(current_user, :role)

    changeset = User.profile_changeset(%User{}, %{})

    {:ok,
    socket
    |> assign(:current_user, current_user)
    |> assign(:is_open, true)
    |> assign(:active_menu_id, nil)
    |> assign(:modale_open, false)
    |> assign(:trigger_submit, false)
    |> assign(:role, BadgeReader.Repo.all(BadgeReader.Accounts.Role))
    |> assign_form(changeset)}
  end

  @impl true
  def handle_params(_params, url, socket) do
    path = URI.parse(url).path
    {:noreply, assign(socket, :current_path, path)}
  end

  @impl true
  def handle_event("trigger_modale", _params ,socket) do
    {:noreply, update(socket, :modale_open, &(!&1))}
  end

  def handle_event("validate_user", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> User.profile_changeset(params)
      |> Map.put(:action, :validate)
    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("submit_user", %{"user" => params}, socket) do
    case Accounts.register_user(params) do
      {:ok, _user} ->
        {:noreply,
        socket
        |> put_flash(:info, "Utilisateur créé avec succès !")
        |> assign(:modale_open, false)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset, as: "user"))
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
        modale_open={@modale_open}
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

                <%!--  Ajouter une vue button --%>
                <button class="btn bg-gray-900 text-gray-100 hover:bg-gray-800 dark:bg-gray-100 dark:text-gray-800 dark:hover:bg-white">
                <svg class="fill-current shrink-0 xs:hidden" width="16" height="16" viewBox="0 0 16 16">
                    <path d="M15 7H9V1c0-.6-.4-1-1-1S7 .4 7 1v6H1c-.6 0-1 .4-1 1s.4 1 1 1h6v6c0 .6.4 1 1 1s1-.4 1-1V9h6c.6 0 1-.4 1-1s-.4-1-1-1z" />
                </svg>
                <span class="max-xs:sr-only">Ajouter une vue</span>
                  </button>
              </div>

            </div>

            <%= if @modale_open do %>
              <div class="fixed inset-0 bg-gray-900/50 z-50 flex items-center justify-center">
                <div class="bg-white dark:bg-gray-800 rounded-lg p-6 shadow-xl w-full max-w-md">

                  <div class="flex justify-between items-center mb-4">
                    <h2 class="text-lg font-bold text-gray-800 dark:text-gray-100">Créer un utilisateur</h2>
                    <button phx-click="trigger_modale" class="text-gray-400 hover:text-gray-600">✕</button>
                  </div>

                  <.form
                    for={@form}
                    id="creat_user"
                    phx-submit="submit_user"
                    phx-change="validate_user"
                  >
                    <.input field={@form[:firstname]} type="text" label="Prénom" required />
                    <.input field={@form[:lastname]} type="text" label="Nom" required />
                    <.input
                      field={@form[:role_id]}
                      type="select"
                      label="Rôle"
                      options={Enum.map(@role, fn r -> {r.name_role, r.id} end)}
                      required
                    />
                    <.input field={@form[:email]} type="email" label="Email" required />
                    <.input field={@form[:password]} type="password" label="Mot de passe" required />

                    <.button class="btn btn-primary w-full mt-4">
                      Créer l'utilisateur
                    </.button>
                  </.form>

                </div>
              </div>
            <% end %>

            <%!--  Cards --%>
            <div class="grid grid-cols-12 gap-6">
              <.user_card01
              current_user = {@current_user}
              is_open={@active_menu_id == "1"}
              on_toggle={JS.push("toggle_menu", value: %{id: "1"})}
              />
            </div>

          </div>
        </main>

      </div>
    </div>
    """
  end
end
