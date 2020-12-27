defmodule DailyHabits.Repo.Migrations.CreateHabits do
  use Ecto.Migration

  def change do
    create table(:habits) do
      add :title, :string, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:habits, [:title])
    create index(:habits, [:user_id])
  end
end
