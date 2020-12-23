defmodule DailyHabitsWeb.PageController do
  use DailyHabitsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
