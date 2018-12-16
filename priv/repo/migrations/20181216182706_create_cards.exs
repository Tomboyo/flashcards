defmodule Flashcards.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :front, :string
      add :back, :string

      timestamps()
    end

  end
end
