defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller
  # import Ecto.Query
  alias Hangman.{Repo, Game}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec get_game(Plug.Conn.t(), map) :: Plug.Conn.t()
  def get_game(conn, %{"id" => id}) do
    #mog says move to model
    game = Repo.get(Game, id)
    |> Repo.preload(:guesses)
    |> IO.inspect()



    conn
    |> assign(:id, id)
    |> assign(:word, Hangman.get_word_in_progress(game))
    |> assign(:wrong_guesses, Game.get_wrong_guesses(game))
    |> render("game.html")

  end

  def create_game(conn, _params) do
    %{id: id} = Hangman.Game.create()

    redirect(conn, to: "/game/#{id}")
  end

  def guess(conn, %{"id" => id, "guess" => %{"letter" => letter}}) do
    #sanitise input here or in model function?
    {game_id, ""} = Integer.parse(id)
    Hangman.Game.guess(game_id, letter)

    conn
    |> redirect(to: "/game/#{id}")
  end
end
