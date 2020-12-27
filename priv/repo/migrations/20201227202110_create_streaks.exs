defmodule DailyHabits.Repo.Migrations.CreateStreaks do
  use Ecto.Migration

  def change do
    create table(:streaks) do
      add :description, :string
      add :start_date, :date
      add :end_data, :date
      add :user_id, references(:users, on_delete: :nothing)
      add :habit_id, references(:habits, on_delete: :nothing)

      timestamps()
    end

    create index(:streaks, [:user_id])
    create index(:streaks, [:habit_id])
  end
end
