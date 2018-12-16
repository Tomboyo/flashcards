defmodule Flashcards.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Flashcards.Repo,
      # Start the endpoint when the application starts
      FlashcardsWeb.Endpoint
      # Starts a worker by calling: Flashcards.Worker.start_link(arg)
      # {Flashcards.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Flashcards.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FlashcardsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
