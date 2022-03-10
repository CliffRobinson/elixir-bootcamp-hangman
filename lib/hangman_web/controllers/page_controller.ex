defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller
  # import Ecto.Query
  alias Hangman.{Repo, Game, Guess}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_game(conn, %{"id" => id}) do
    game = Repo.get(Game, id)
    |> Repo.preload(:guesses)
    |> IO.inspect()

    conn
    |> assign(:id, id)
    |> assign(:word, Hangman.get_word_in_progress(game))
    # |> assign(:game, game)
    |> render("game.html")

  end

  def create_game(conn, _params) do
    %{id: id} = Hangman.Game.create()

    redirect(conn, to: "/game/#{id}")
  end

  def guess(conn, %{"id" => id, "guess" => %{"letter" => letter}}) do
    {game_id, ""} = Integer.parse(id)
    # TODO add unique constraint on letter + game_id
    # TODO: put this into schema function
    {:ok, _} = Repo.insert(%Guess{letter: letter, game_id: game_id})

    conn
    |> redirect(to: "/game/#{id}")
  end
end
