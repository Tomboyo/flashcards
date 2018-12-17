defmodule FlashcardsWeb.FlashcardsView do
  use FlashcardsWeb, :view
  alias Flashcards.Card

  def render_card(conn, %Card{id: id, front: front, back: back}) do
    render("card.html", [
      front: front,
      back: back,
      edit_path: Routes.flashcards_path(conn, :edit, id)
    ])
  end
end
