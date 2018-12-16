defmodule FlashcardsWeb.FlashcardsController do
  use FlashcardsWeb, :controller

  def index(conn, _params) do
    cards = get_cards()
    render(conn, "index.html", [cards: cards])
  end

  def get_cards() do
    for id <- 1..10,
        title = "Card #{id}",
        do: {id, title, "Card Content"}
  end
end
