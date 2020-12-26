defmodule DailyHabitsWeb.TestController do
  use DailyHabitsWeb, :controller
  alias DailyHabits.Repo

  def show(conn, _params) do
    user = Repo.get(DailyHabits.Users.User, conn.private[:user_id])

    json(conn, %{logged_token: conn.private[:api_access_token],
     user_id: conn.private[:user_id],
      name: user.name,
      email: user.email})
    conn
  end
end
