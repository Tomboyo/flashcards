defmodule FlashcardsWeb.FlashcardsController do
  use FlashcardsWeb, :controller
  alias Flashcards.{Repo, Card}

  def index(conn, _params) do
    cards = get_cards()
    render(conn, "index.html", [cards: cards])
  end

  defp get_cards() do
    Repo.all(Card)
  end

  def new(conn, params) do
    conn = case Repo.insert(%Card{}) do
      {:ok, card} -> conn
      _ -> put_flash(conn, :error, "Could not create flashcard :(")
    end
    redirect(conn, to: Routes.flashcards_path(conn, :index))
  end
end
