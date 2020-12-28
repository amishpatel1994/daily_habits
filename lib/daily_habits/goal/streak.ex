defmodule DailyHabits.Goal.Streak do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streaks" do
    field :description, :string
    field :end_date, :date
    field :last_checkin_date, :date
    field :start_date, :date
    belongs_to :user, DailyHabits.Users.User
    belongs_to :habit, DailyHabits.Goal.Habit
    timestamps()
  end

  @doc false
  def changeset(streak, attrs) do
    streak
    |> cast(attrs, [:description, :start_date, :end_date, :last_checkin_date, :user_id, :habit_id])
    |> validate_required([:start_date, :user_id, :habit_id])
  end
end
