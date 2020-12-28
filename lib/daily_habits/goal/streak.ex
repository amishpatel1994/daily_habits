defmodule DailyHabits.Goal.Streak do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias DailyHabits.Goal.Habit

  schema "streaks" do
    field :description, :string
    field :end_date, :date
    field :last_checkin_date, :date
    field :start_date, :date
    belongs_to :user, DailyHabits.Users.User
    belongs_to :habit, Habit
    timestamps()
  end

  @doc false
  def changeset(streak, attrs) do
    streak
    |> cast(attrs, [:description, :start_date, :end_date, :last_checkin_date, :user_id, :habit_id])
    |> validate_required([:start_date, :user_id, :habit_id])
  end

  def by_user_id(query, user_id) do
    from(s in query, where: s.user_id == ^user_id)
  end

  def active(query) do
    from(s in query, where: is_nil(s.end_date))
  end

  def preload_habit(query) do
    habit_query = from c in Habit, select: c.title
    from(s in query, preload: [habit: ^habit_query])
  end
end
