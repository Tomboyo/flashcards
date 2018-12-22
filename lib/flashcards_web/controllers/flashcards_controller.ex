defmodule FlashcardsWeb.FlashcardsController do
  use FlashcardsWeb, :controller
  alias Flashcards.{Repo, Card}

  def index_page(conn, _params) do
    cards = Repo.all(Card)
    render(conn, "index.html", [
      conn: conn,
      csrf_token: get_csrf_token(),
      cards: cards
    ])
  end

  def create_page(conn, _params) do
    render(conn, "new.html", [
      csrf_token: get_csrf_token(),
      form_submit_path: Routes.flashcards_path(conn, :create)
    ])
  end

  def edit_page(conn, %{"id" => id}) do
    %Card{front: front, back: back} = Repo.get(Card, id)
    render(conn, "edit.html", [
      id: id,
      front: front,
      back: back,
      csrf_token: get_csrf_token()
    ])
  end

  def create(conn, %{"front" => front, "back" => back}) do
    Repo.insert(%Card{front: front, back: back})
    redirect(conn, to: Routes.flashcards_path(conn, :index_page))
  end

  def edit(conn, %{"id" => id, "front" => front, "back" => back}) do
    {id, _} = Integer.parse(id)

    Repo.get(Card, id)
    |> Card.changeset(%{front: front, back: back})
    |> Repo.update()

    redirect conn, to: Routes.flashcards_path(conn, :index_page)
  end

  def delete(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)

    Repo.delete(%Card{id: id})

    redirect conn, to: Routes.flashcards_path(conn, :index_page)
  end
end
