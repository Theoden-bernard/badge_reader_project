defmodule BadgeReader.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BadgeReaderWeb.Telemetry,
      BadgeReader.Repo,
      {DNSCluster, query: Application.get_env(:badge_reader, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BadgeReader.PubSub},
      # Start a worker by calling: BadgeReader.Worker.start_link(arg)
      # {BadgeReader.Worker, arg},
      # Start to serve requests, typically the last entry
      BadgeReaderWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BadgeReader.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BadgeReaderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
