defmodule Hangman.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :word, :string

      timestamps()
    end
  end
end
