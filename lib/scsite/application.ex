defmodule Scsite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScsiteWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:scsite, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Scsite.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Scsite.Finch},
      # Start a worker by calling: Scsite.Worker.start_link(arg)
      # {Scsite.Worker, arg},
      # Start to serve requests, typically the last entry
      ScsiteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scsite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScsiteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
