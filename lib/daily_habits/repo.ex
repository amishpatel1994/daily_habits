defmodule DailyHabits.Repo do
  use Ecto.Repo,
    otp_app: :daily_habits,
    adapter: Ecto.Adapters.Postgres
end
