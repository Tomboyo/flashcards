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

  # PUT and PATCH are tunneled through POST
  def create(conn, params) do
    if Map.has_key?(params, :_method) do
      case params do
        %{_method: "PUT"}   -> edit_submit(conn, params)
        %{_method: "PATCH"} -> edit_submit(conn, params)
      end
    else
      %{"front" => front, "back" => back} = params
      Repo.insert(%Card{front: front, back: back})
      redirect(conn, to: Routes.flashcards_path(conn, :index))
    end
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

  defp edit_submit(conn, _params) do
    redirect conn, to: Routes.flashcards_path(conn, :update)
  end

  def update(conn, %{"id" => id, "front" => front, "back" => back}) do
    {id, _} = Integer.parse(id)

    Repo.get(Card, id)
    |> Card.changeset(%{front: front, back: back})
    |> Repo.update()

    redirect conn, to: Routes.flashcards_path(conn, :index)
  end
end
