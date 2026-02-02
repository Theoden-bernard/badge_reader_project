defmodule BadgeReader.User do
    use Ecto.Schema

    schema "user" do
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :password, :string
    end


    def creat_user(new_user, params) do
        changeset(new_user, params)
        new_user = params
        BadgeReader.Repo.insert(new_user)
    end

    def changeset(user, params \\ %{}) do
        user
        |> Ecto.Changeset.cast(params, [:id, :first_name, :last_name, :email, :password])
        |> Ecto.Changeset.validate_required([:first_name, :last_name, :email, :password])
    end
end
