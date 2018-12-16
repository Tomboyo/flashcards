defmodule FlashcardsWeb.FlashcardsController do
  use FlashcardsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
