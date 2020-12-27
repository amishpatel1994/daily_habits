defmodule DailyHabits.Goal.Habit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "habits" do
    field :title, :string
    field :user_id, :id
    has_many :streaks, DailyHabits.Goal.Streak
    timestamps()
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
