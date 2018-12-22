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

    get "/", FlashcardsController, :index_page

    scope "/flashcards" do
      get "/", FlashcardsController, :index_page
      get "/create", FlashcardsController, :create_page
      get "/edit/:id", FlashcardsController, :edit_page
      get "/show/:id", FlashcardsController, :show_page

      post "/create", FlashcardsController, :create
      post "/edit", FlashcardsController, :edit
      post "/delete", FlashcardsController, :delete
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", FlashcardsWeb do
  #   pipe_through :api
  # end
end
