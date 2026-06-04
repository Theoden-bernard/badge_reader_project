defmodule BadgeReader.RoleManager do
  alias BadgeReader.RoleManager.Role
  alias BadgeReader.Repo

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

  def list_roles() do
    Role
    |> Repo.all()
  end

  def get_role_by_name(name_role)do
    Role
    |> Repo.get_by(name_role: name_role)
  end


  def get_role!(id) do
    Role
    |> Repo.get(id)
  end

end
