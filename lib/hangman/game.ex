defmodule Hangman.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias Hangman.{Repo, Guess}

  schema "games" do
    field :word, :string
    has_many :guesses, Guess

    timestamps()
  end

  def create do
    %Game{
      word: get_random_word()
    }
    |> Repo.insert!()
  end

  def guess(game_id, letter) do
    # TODO add unique constraint on letter + game_id
    {:ok, _} = Repo.insert(%Guess{letter: letter, game_id: game_id})
  end

  @doc false
  def changeset(game, attrs) do

    game
    |> cast(attrs, [:word])
    |> validate_required([:word])
  end

  def get_random_word() do
    {:ok, word_string} = File.read("/usr/share/dict/words")

    words = String.split(word_string, "\n", trim: true)

    Enum.random(words) |> String.downcase()
  end

  def get_wrong_guesses(game) do
    guessed_letters(game) -- target_letters(game)
  end

  defp target_letters(game) do
    game.word
    |> String.graphemes()
    |> Enum.uniq()
  end

  defp guessed_letters(game) do
    game.guesses
    |> Enum.map(& &1.letter)
    |> Enum.uniq()
  end
end
