defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller
  import Hangman
  alias Hangman.{Repo, Game}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create_game(conn, _params) do
    {:ok, %{:id => id, :word => word}} = Repo.insert(%Game{word: "elixir"})

    conn
    |> assign(:id, id)
    |> assign(:word, get_word_in_progress(word, []))
    |> render("game.html")
  end

  def guess(conn, _params) do
    conn
    |> assign(:id, 1)
    |> assign(:word, get_word_in_progress("", []))
    |> render("game.html")
  end
end
