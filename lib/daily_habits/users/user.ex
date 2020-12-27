defmodule DailyHabits.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias DailyHabits.Goals.{Habit, Streak}

  schema "users" do
    pow_user_fields()
    field :name, :string
    has_many :habits, Habit
    has_many :streaks, Streak

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:name])
  end
end
