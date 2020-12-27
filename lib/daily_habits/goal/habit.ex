defmodule DailyHabits.Goal.Habit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "habits" do
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
