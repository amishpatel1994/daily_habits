defmodule DailyHabits.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      DailyHabits.Repo,
      # Start the endpoint when the application starts
      DailyHabitsWeb.Endpoint
      # Starts a worker by calling: DailyHabits.Worker.start_link(arg)
      # {DailyHabits.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DailyHabits.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DailyHabitsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
