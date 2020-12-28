defmodule DailyHabitsWeb.HabitView do
  use DailyHabitsWeb, :view
  alias DailyHabitsWeb.HabitView

  def render("index.json", %{habits: habits}) do
    %{habits: render_many(habits, HabitView, "habit.json")}
  end

  def render("show.json", %{habit: habit}) do
    %{habit: render_one(habit, HabitView, "habit.json")}
  end

  def render("habit.json", %{habit: habit}) do
    %{id: habit.id,
      title: habit.title}
  end
end
