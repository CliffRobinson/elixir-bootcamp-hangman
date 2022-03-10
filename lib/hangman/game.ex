defmodule Hangman.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias Hangman.Repo

  schema "games" do
    field :word, :string
    has_many :guesses, Hangman.Guess

    timestamps()
  end

  def create do
    %Game{
      word: get_random_word()
    }
    |> Repo.insert!()
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
end
