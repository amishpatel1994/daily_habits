defmodule DailyHabitsWeb.StreakView do
  use DailyHabitsWeb, :view
  alias DailyHabitsWeb.StreakView

  def render("index.json", %{streaks: streaks}) do
    %{data: render_many(streaks, StreakView, "streak.json")}
  end

  def render("show.json", %{streak: streak}) do
    %{data: render_one(streak, StreakView, "streak.json")}
  end

  def render("streak.json", %{streak: streak}) do
    %{id: streak.id,
      description: streak.description,
      start_date: streak.start_date,
      end_date: streak.end_date,
      habit: streak.habit
    }
  end
end
