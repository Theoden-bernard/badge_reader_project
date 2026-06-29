defmodule CreateUserTest do
  use ExUnit.Case
  use BadgeReader.DataCase
  alias BadgeReader.{Accounts, RoleManager}
  alias BadgeReader.Accounts.User

  # setup do
  #   assert {:ok, role} = RoleManager.create_role(%{
  #     name_role: "test_role"
  #   })

  #   assert {:ok, %User{} = user1} = Accounts.admin_create_user(%{
  #     firstname: "Alice",
  #     lastname: "Bob",
  #     role_id: role.id,
  #     email: "test@colint.school",
  #     password: "Test12345678"
  #   })

  #   %{user1: user1, role: role}
  # end

  # test "register valide user", %{user1: user, role: role} do
  #   assert %User{firstname: "Alice",
  #     lastname: "Bob",
  #     email: "test@colint.school",
  #     password: "Test12345678"
  #   } = user
  # end

  # test "register user if email already exist", %{user1: _user, role: role} do
  #   assert {:error, changeset} = Accounts.register_user(%{
  #     firstname: "toto",
  #     lastname: "tata",
  #     role_id: role.id,
  #     email: "test@colint.school",
  #     password: "Test12345678"
  #     })

  #   assert %{email: ["has already been taken"]} = errors_on(changeset)
  # end

  # test "password too short", %{role: role}do
  #   assert {:error, changeset} = Accounts.register_user(%{firstname: "Alice", lastname: "Bob", role_id: role.id, email: "test@colint.school",password: "Test"})

  #   assert %{password: ["should be at least 12 character(s)"]} = errors_on(changeset)
  # end
end
