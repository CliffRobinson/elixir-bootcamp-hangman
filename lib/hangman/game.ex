defmodule Hangman.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :word, :string

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:word])
    |> validate_required([:word])
  end
end
