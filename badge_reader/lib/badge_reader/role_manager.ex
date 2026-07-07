defmodule BadgeReader.RoleManager do
  @moduledoc """
  The RoleManager context.

  Provides an API boundary to manage system roles, track permissions, and retrieve operational
  clearance levels required by the access control logic.

  ## Features

  * **Role Provisioning:** Persists system roles into the database validated against a centralized changeset definitions schema.
  * **Identity Resolution:** Fetches single configuration records using absolute database primary keys (`id`) or human-readable names (`name_role`).
  * **Global Directory Mapping:** Fetches unlinked data trees for high-level administration dropdowns, metrics, or assignment matrices.

  ## Examples

  Registering a new permission profile group:

    {:ok, role} = BadgeReader.RoleManager.create_role(%{name_role: "Security Guard"})

  Retrieving specialized verification profiles:

    role = BadgeReader.RoleManager.get_role_by_name("Administrator")
  """

  alias BadgeReader.Repo
  alias BadgeReader.RoleManager.Role

  @doc """
  create role

  ## Examples

    iex> create_role(%{field: value})
    {:ok, %role{}}

    iex> create_role(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def list_roles do
    Role
    |> Repo.all()
  end

  def get_role_by_name(name_role) do
    Role
    |> Repo.get_by(name_role: name_role)
  end

  def get_role!(id) do
    Role
    |> Repo.get(id)
  end
end
