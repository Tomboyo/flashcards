defmodule FlashcardsWeb.FlashcardsController do
  use FlashcardsWeb, :controller
  alias Flashcards.{Repo, Card}

  def index(conn, _params) do
    cards = get_cards()
    render(conn, "index.html", [conn: conn, cards: cards])
  end

  defp get_cards() do
    Repo.all(Card)
  end

  def new(conn, _params) do
    conn = case Repo.insert(%Card{}) do
      {:ok, _card} -> conn
      _ -> put_flash(conn, :error, "Could not create flashcard :(")
    end
    redirect(conn, to: Routes.flashcards_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    %Card{front: front, back: back} = Repo.get(Card, id)
    render(conn, "edit.html", [
      front: front,
      back: back,
      id: id,
      csrf_token: get_csrf_token()
    ])
  end

  def show(conn, params) do
    case params do
      %{_method: _method} -> redirect conn, to: Routes.flashcards_path(conn, :update)
      _ -> redirect conn, to: Routes.flashcards_path(conn, :index)
    end
  end

  def update(conn, %{"id" => id, "front" => front, "back" => back}) do
    {id, _} = Integer.parse(id)

    Repo.get(Card, id)
    |> Card.changeset(%{front: front, back: back})
    |> Repo.update()

    redirect conn, to: Routes.flashcards_path(conn, :index)
  end
end
