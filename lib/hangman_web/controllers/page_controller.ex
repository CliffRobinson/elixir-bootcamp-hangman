defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller
  import Ecto.Query
  alias Hangman.{Repo, Game, Guess}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_game(conn, %{"id" => id}) do
    game = Repo.get id
    IO.inspect(game)
    Repo.preload(game, :guesses)

    guesses = Repo.all(from g in Guess, where: g.game_id == ^id)
    # IO.inspect(guesses)

    conn
    |> assign(:id, id)
    |> assign(:word, Hangman.get_word_in_progress("test", []))
    |> render("game.html")

  end

  def create_game(conn, _params) do
    # TODO: Create random word
    {:ok, %{:id => id}} = Repo.insert(%Game{word: "elixir"})

    conn
    |> redirect(to: "/game/#{id}")
  end

  def guess(conn, %{"id" => id, "guess" => %{"letter" => letter}}) do
    {game_id, ""} = Integer.parse(id)
    # TODO add unique constraint on letter + game_id
    {:ok, _} = Repo.insert(%Guess{letter: letter, game_id: game_id})

    conn
    |> redirect(to: "/game/#{id}")
  end
end
