defmodule Flashcards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :front, :string
    field :back, :string

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:front, :back])
    |> validate_required([:front, :back])
  end
end
