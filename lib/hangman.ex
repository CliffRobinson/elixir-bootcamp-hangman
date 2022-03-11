defmodule Hangman do
  @moduledoc """
  Hangman keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  # TODO: do
  def get_word_in_progress(game) do

    # IO.puts("args are:")
    # IO.inspect(%{:word => word, :game => game})

    String.split(game.word, "", trim: true)
    |> Enum.map(fn letter ->
      if (Enum.any?(game.guesses, fn guess -> guess.letter == letter end)) do
        letter
      else
        "?"
      end
    end)
  end



  # def reduce_wip_and_guesses(word, arg_guesses) do

  #   guess_letters = Enum.map(arg_guesses, fn el -> el.letter end)

  #   String.split(word, "", trim: true)
  #   |> Enum.reduce(%{wip: [], wrong_guesses: guess_letters}, fn (letter, %{:wip => wip, :wrong_guesses => acc_wrong_guesses}) ->
  #     if (Enum.any?(arg_guesses, fn guess -> guess == letter end)) do
  #       new_wip = wip ++ letter
  #       #this will remove any duplicate wrong guesses, but there shouldn't be any.
  #       new_wrong_guesses = Enum.reject(acc_wrong_guesses, fn guess ->  guess == letter end)
  #       %{wip: new_wip, wrong_guesses: new_wrong_guesses}
  #     else
  #       %{wip: wip ++ ["_"], wrong_guesses: acc_wrong_guesses}
  #     end
  #   end)
  # end
end
