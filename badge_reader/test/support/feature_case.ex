defmodule BadgeReaderWeb.FeatureCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      use Wallaby.DSL
      use BadgeReaderWeb, :verified_routes

      @endpoint BadgeReaderWeb.Endpoint
    end
  end

  setup tags do
    :ok = Sandbox.checkout(BadgeReader.Repo)

    unless tags[:async] do
      Sandbox.mode(BadgeReader.Repo, {:shared, self()})
    end

    {:ok, session} = Wallaby.start_session(metadata: %{})
    {:ok, session: session}
  end
end
