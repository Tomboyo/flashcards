defmodule FlashcardsWeb.Router do
  use FlashcardsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FlashcardsWeb do
    pipe_through :browser

    get "/", FlashcardsController, :index
    resources "/flashcard", FlashcardsController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FlashcardsWeb do
  #   pipe_through :api
  # end
end
