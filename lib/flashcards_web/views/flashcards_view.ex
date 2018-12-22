defmodule FlashcardsWeb.FlashcardsView do
  use FlashcardsWeb, :view
  alias Flashcards.Card

  def render_card(conn, csrf_token, %Card{id: id, front: front, back: back}) do
    render("card.html", [
      id: id,
      front: front,
      back: back,
      csrf_token: csrf_token,
      conn: conn
    ])
  end
end
