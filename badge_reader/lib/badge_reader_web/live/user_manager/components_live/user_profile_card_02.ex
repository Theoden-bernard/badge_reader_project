defmodule BadgeReaderWeb.UserManager.ComponentsLive.UserProfileCard02 do
  use BadgeReaderWeb, :live_component
  alias BadgeReader.{Accounts}
  alias BadgeReader.Accounts.User

  def mount(socket) do
    {:ok,
    socket
    |> assign(:edit, false)}
  end

  def update(%{user: current_user}, socket) do
    form = current_user
    |> User.profile_changeset(%{})
    |> to_form()

    {:ok,
    socket
    |> assign(:current_user, current_user)
    |> assign(:role, BadgeReader.Repo.all(BadgeReader.RoleManager.Role))
    |> assign(:form, form)}
  end

  def handle_event("toggle_edit", _attrs, socket) do
    edit = socket.assigns.edit

    {:noreply,
    socket
    |> assign(:edit, !edit)}
  end

  def handle_event("validate_info", user_info, socket) do
    current_user = socket.assigns.current_user
    changeset = current_user
    |> User.profile_changeset(user_info["user"])
    |> Map.put(:action, :validate)

    {:noreply,
    socket
    |> assign_form(changeset)}
  end

  def handle_event("submit_user", user_info, socket) do
    current_user = socket.assigns.current_user

    case Accounts.change_info_user(current_user, user_info["user"]) do
      {:ok, user} ->
        {:noreply,
        socket
        |> put_flash(:info, "Utilisateur modifier avec succès !")
        |> assign(:current_user, user)
        |> assign(:edit, false)}
      {:error, %Ecto.Changeset{} = changeset} ->
         {:noreply, assign_form(socket, changeset)}

    end
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full bg-white dark:bg-gray-800 shadow-xs rounded-xl">
      <div class="w-full px-5">
        <header class="flex justify-between items-start pt-4">
          <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-2">
            Ses informations
          </h2>
        </header>
        <h3 class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase mb-3">
          SES INFORMATION PERSONNEL
        </h3>

        <.form
        for={@form}
        id="edit_user"
        phx-submit="submit_user"
        phx-change="validate_info"
        phx-target={@myself}
        >
          <div class="bg-white dark:bg-gray-800 border-gray-400 mb-5 overflow-hidden shadow rounded-lg border">
            <div class="border-t border-gray-200 px-4 py-5 sm:p-0">
              <dl class="sm:divide-y sm:divide-gray-200">
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Nom
                  </dt>
                  <dd phx-target={@myself} phx-click="toggle_edit" class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%= if @edit == false do %>
                    <%= @current_user.lastname %>
                    <% else %>
                    <.input field={@form[:lastname]} type="text" required />
                    <% end %>
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Prénom
                  </dt>
                  <dd phx-target={@myself} phx-click="toggle_edit" class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%= if @edit == false do %>
                    <%= @current_user.firstname %>
                    <% else %>
                    <.input field={@form[:firstname]} type="text" required />
                    <% end %>
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Addresse email
                  </dt>
                  <dd phx-target={@myself} phx-click="toggle_edit" class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%= if @edit == false do %>
                    <%= @current_user.email %>
                    <% else %>
                    <.input field={@form[:email]} type="email" required />
                    <% end %>
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
                  <dd phx-target={@myself} phx-click="toggle_edit" class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%= if @edit == false do %>
                    <%= if @current_user.role, do: @current_user.role.name_role, else: "Aucun rôle" %>
                    <% else %>
                    <.input
                      field={@form[:role_id]}
                      type="select"
                      options={Enum.map(@role, fn r -> {r.name_role, r.id} end)}
                      value="@role"
                      required
                    />
                    <% end %>
                  </dd>
                </div>
                <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                  <dt class="text-sm font-medium text-gray-500">
                    Badge
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                    <%!-- <%= if @current_user.badge, do: @current_user.badge.name_badge, else: "Badge non attribuer" %> --%>
                  </dd>
                </div>

              </dl>
            </div>
          </div>
          <div class="flex justify-end mb-5">
            <.button type="submit" class="btn btn-primary w-full mt-4">
              Modifier l'utilisateur
            </.button>
          </div>
        </.form>
      </div>
    </div>
    """
  end
end
