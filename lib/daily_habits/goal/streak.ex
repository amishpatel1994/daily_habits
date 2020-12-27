defmodule DailyHabits.Goal.Streak do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streaks" do
    field :description, :string
    field :end_data, :date
    field :start_date, :date
    field :user_id, :id
    field :habit_id, :id

    timestamps()
  end

  @doc false
  def changeset(streak, attrs) do
    streak
    |> cast(attrs, [:description, :start_date, :end_data])
    |> validate_required([:description, :start_date, :end_data])
  end
end
