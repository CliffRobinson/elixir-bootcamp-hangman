defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller
  alias Hangman.{Repo, Game}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create_game(conn, _params) do
    Repo.insert(%Game{word: "elixir"})

    conn
    |>put_flash(:info, "created new game")
    |> render("index.html")
  end
end
