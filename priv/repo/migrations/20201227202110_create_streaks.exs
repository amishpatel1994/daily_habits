defmodule DailyHabits.Repo.Migrations.CreateStreaks do
  use Ecto.Migration

  def change do
    create table(:streaks) do
      add :description, :string, null: true
      add :start_date, :date, null: false
      add :end_date, :date, null: true
      add :last_checkin_date, :date, null: true
      add :user_id, references(:users, on_delete: :nothing)
      add :habit_id, references(:habits, on_delete: :nothing)

      timestamps()
    end

    create index(:streaks, [:user_id])
    create index(:streaks, [:habit_id])
  end
end
