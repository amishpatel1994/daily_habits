defmodule DailyHabits.Goal.Habit do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

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

  def by_title(query, nil), do: query
  def by_title(query, title) do
    pattern = "%#{title}%"
    from(h in query, where: ilike(h.title, ^pattern))
  end
end
