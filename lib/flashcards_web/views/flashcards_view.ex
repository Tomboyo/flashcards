defmodule FlashcardsWeb.FlashcardsView do
  use FlashcardsWeb, :view
  alias Flashcards.Card

  def render_card(%Card{front: front, back: back}) do
    render("card.html", [front: front, back: back])
  end
end
