defmodule FlashcardsWeb.FlashcardsController do
  use FlashcardsWeb, :controller
  alias Flashcards.{Repo, Card}

  def index(conn, _params) do
    cards = Repo.all(Card)
    render(conn, "index.html", [conn: conn, cards: cards])
  end

  def new(conn, _params) do
    render(conn, "new.html", [
      csrf_token: get_csrf_token(),
      form_submit_path: Routes.flashcards_path(conn, :create)
    ])
  end

  def edit(conn, %{"id" => id}) do
    %Card{front: front, back: back} = Repo.get(Card, id)
    render(conn, "edit.html", [
      front: front,
      back: back,
      csrf_token: get_csrf_token(),
      form_submit_path: Routes.flashcards_path(conn, :update, id)
    ])
  end

  # Form data for PUT and PATCH are tunneled through POST
  def create(conn, %{_method: "PUT"} = params),
      do: update(conn, params)
  def create(conn, %{_method: "PATCH"} = params),
      do: update(conn, params)
  def create(conn, %{"front" => front, "back" => back}) do
    Repo.insert(%Card{front: front, back: back})
    redirect(conn, to: Routes.flashcards_path(conn, :index))
  end

  def update(conn, %{"id" => id, "front" => front, "back" => back}) do
    {id, _} = Integer.parse(id)

    Repo.get(Card, id)
    |> Card.changeset(%{front: front, back: back})
    |> Repo.update()

    redirect conn, to: Routes.flashcards_path(conn, :index)
  end
end
