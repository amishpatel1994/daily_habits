# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DailyHabits.Repo.insert!(%DailyHabits.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias DailyHabits.Repo
alias DailyHabits.Users.User
alias DailyHabits.Goal.{Habit, Streak}

# Populate users
Enum.each(["1","2","3","4"], fn num ->
  params = %{name: "Test #{num}",
              email: "test#{num}@example.com",
              password: "password", password_confirmation: "password"}
  User.changeset(%User{}, params) |> Repo.insert!()
end)

# Populate some habits
habits = [
  "Yoga",
  "Meditation",
  "Drink Water",
  "Take Vitamin pills",
  "Journal",
  "Read a book",
  "Wake up early",
  "Walk the dog",
  "Get some sun",
  "Exercise",
  "Floss Teeth",
  "Drink green tea"
]
Enum.each(habits, fn habit ->
  Habit.changeset(%Habit{}, %{title: habit}) |> Repo.insert!()
end)

# Add some streaks for a user
streaks = [
  %{  description: "Pranayam for 15 minutes",
      start_date: ~D[2018-01-01], end_date: ~D[2018-01-23],
      user_id: 1, habit_id: 1},
  %{  description: "Pranayam for 15 minutes",
      start_date: ~D[2018-03-01], end_date: ~D[2018-08-23],
      user_id: 1, habit_id: 1},
  %{  description: "Pranayam for 15 minutes",
      start_date: ~D[2020-01-01], last_checkin_date: ~D[2020-10-23],
      user_id: 1, habit_id: 1},
  %{  description: "Pranayam for 15 minutes",
      start_date: ~D[2020-01-01], last_checkin_date: ~D[2020-12-28],
      user_id: 1, habit_id: 2},
  %{  description: "Pranayam for 20 minutes",
      start_date: ~D[2019-01-01], end_date: ~D[2019-01-23],
      user_id: 2, habit_id: 1},
  %{  description: "Pranayam for 20 minutes",
      start_date: ~D[2019-03-01], end_date: ~D[2019-08-23],
      user_id: 2, habit_id: 1},
  %{  description: "Pranayam for 20 minutes",
      start_date: ~D[2020-04-01], last_checkin_date: ~D[2020-11-23],
      user_id: 2, habit_id: 1},
]
Enum.each(streaks, fn params ->
  Streak.changeset(%Streak{}, params) |> Repo.insert!()
end)

IO.puts("Hello")
