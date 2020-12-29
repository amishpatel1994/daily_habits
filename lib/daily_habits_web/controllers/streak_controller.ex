defmodule DailyHabitsWeb.StreakController do
  use DailyHabitsWeb, :controller

  alias DailyHabits.Goal
  alias DailyHabits.Goal.{Habit, Streak}

  action_fallback DailyHabitsWeb.FallbackController

  def index(conn, _params) do
    streaks = Goal.get_active_streaks(conn.private[:user_id])
    render(conn, "index.json", streaks: streaks)
  end

  def create(conn, %{"streak" => params}) do
    with {:ok, %Habit{} = habit} <- Goal.find_or_create_habit(params),
         streak_params <- Map.merge(params, %{"habit_id" => habit.id, "user_id" => conn.private[:user_id]}),
         {:ok, %Streak{} = streak} <- Goal.create_streak(streak_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.streak_path(conn, :show, streak))
      |> render("show.json", streak: streak)
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    streak = Goal.get_streak!(id)
    render(conn, "show.json", streak: streak)
  end

  def update(conn, %{"id" => id, "streak" => streak_params}) do
    streak = Goal.get_streak!(id)

    with {:ok, %Streak{} = streak} <- Goal.update_streak(streak, streak_params) do
      render(conn, "show.json", streak: streak)
    end
  end

  def delete(conn, %{"id" => id}) do
    streak = Goal.get_streak!(id)

    with {:ok, %Streak{}} <- Goal.delete_streak(streak) do
      send_resp(conn, :no_content, "")
    end
  end
end
