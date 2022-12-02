defmodule Resuelvefc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ResuelvefcWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Resuelvefc.PubSub},
      # Start the Endpoint (http/https)
      ResuelvefcWeb.Endpoint
      # Start a worker by calling: Resuelvefc.Worker.start_link(arg)
      # {Resuelvefc.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Resuelvefc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ResuelvefcWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
