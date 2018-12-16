defmodule FlashcardsWeb.FlashcardsView do
  use FlashcardsWeb, :view

  def render_card({id, title, content}) do
    render("card.html", [id: id, title: title, content: content])
  end
end
