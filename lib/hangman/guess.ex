defmodule Hangman.Guess do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guesses" do
    field :letter, :string
    field :game_id, :id
    belongs_to :game, Game, foreign_key: :game_id

    timestamps()
  end

  @doc false
  def changeset(guess, attrs) do
    guess
    |> cast(attrs, [:letter])
    |> validate_required([:letter])
  end
end
