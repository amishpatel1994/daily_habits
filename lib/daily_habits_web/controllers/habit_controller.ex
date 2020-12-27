defmodule DailyHabitsWeb.HabitController do
  use DailyHabitsWeb, :controller

  alias DailyHabits.Goal
  alias DailyHabits.Goal.Habit

  action_fallback DailyHabitsWeb.FallbackController

  def index(conn, _params) do
    habits = Goal.list_habits()
    render(conn, "index.json", habits: habits)
  end

  def create(conn, %{"habit" => habit_params}) do
    with {:ok, %Habit{} = habit} <- Goal.create_habit(habit_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.habit_path(conn, :show, habit))
      |> render("show.json", habit: habit)
    end
  end

  def show(conn, %{"id" => id}) do
    habit = Goal.get_habit!(id)
    render(conn, "show.json", habit: habit)
  end

  def update(conn, %{"id" => id, "habit" => habit_params}) do
    habit = Goal.get_habit!(id)

    with {:ok, %Habit{} = habit} <- Goal.update_habit(habit, habit_params) do
      render(conn, "show.json", habit: habit)
    end
  end

  def delete(conn, %{"id" => id}) do
    habit = Goal.get_habit!(id)

    with {:ok, %Habit{}} <- Goal.delete_habit(habit) do
      send_resp(conn, :no_content, "")
    end
  end
end
