defmodule Hangman.Repo.Migrations.CreateGuesses do
  use Ecto.Migration

  def change do
    create table(:guesses) do
      add :letter, :string
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:guesses, [:game_id])
  end
end
