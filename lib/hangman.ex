defmodule Hangman do
  @moduledoc """
  Hangman keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  # TODO: move to game.ex?
  def get_word_in_progress(game) do
    String.split(game.word, "", trim: true)
    |> Enum.map(fn letter ->
      if (Enum.any?(game.guesses, fn guess -> guess.letter == letter end)) do
        letter
      else
        "?"
      end
    end)
  end
end
