defmodule DailyHabits.Goal do
  @moduledoc """
  The Goal context.
  """

  import Ecto.Query, warn: false
  alias DailyHabits.Repo

  alias DailyHabits.Goal.Habit

  @doc """
  Returns the list of habits.

  ## Examples

      iex> list_habits()
      [%Habit{}, ...]

  """
  def list_habits(%{"habit" => habit}) do
    Habit
    |> Habit.by_title(habit)
    |> Repo.all()
  end
  def list_habits() do
    Repo.all(Habit)
  end

  def find_or_create_habit(%{"title" => title} = params) do
    case Map.get(params, "habit_id") do
      nil ->
        Habit.changeset(%Habit{}, %{title: title})
        |> Repo.insert()
      id ->
        {:ok, Repo.get(Habit, id)}
    end
  end

  @doc """
  Gets a single habit.

  Raises `Ecto.NoResultsError` if the Habit does not exist.

  ## Examples

      iex> get_habit!(123)
      %Habit{}

      iex> get_habit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_habit!(id), do: Repo.get!(Habit, id)

  @doc """
  Deletes a habit.

  ## Examples

      iex> delete_habit(habit)
      {:ok, %Habit{}}

      iex> delete_habit(habit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_habit(%Habit{} = habit) do
    Repo.delete(habit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking habit changes.

  ## Examples

      iex> change_habit(habit)
      %Ecto.Changeset{source: %Habit{}}

  """
  def change_habit(%Habit{} = habit) do
    Habit.changeset(habit, %{})
  end

  alias DailyHabits.Goal.Streak

  @doc """
  Returns the list of streaks.

  ## Examples

      iex> list_streaks()
      [%Streak{}, ...]

  """
  def list_streaks do
    Repo.all(Streak)
  end

  def get_active_streaks(user_id) do
    Streak
    |> Streak.active()
    |> Streak.by_user_id(user_id)
    |> Streak.preload_habit()
    |> Repo.all()
  end

  @doc """
  Gets a single streak.

  Raises `Ecto.NoResultsError` if the Streak does not exist.

  ## Examples

      iex> get_streak!(123)
      %Streak{}

      iex> get_streak!(456)
      ** (Ecto.NoResultsError)

  """
  def get_streak!(id), do: Repo.get!(Streak, id)

  @doc """
  Creates a streak.

  ## Examples

      iex> create_streak(%{field: value})
      {:ok, %Streak{}}

      iex> create_streak(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_streak(attrs \\ %{}) do
    %Streak{}
    |> Streak.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, streak} -> {:ok, Repo.preload(streak, :habit)}
      error -> error
    end
  end

  @doc """
  Updates a streak.

  ## Examples

      iex> update_streak(streak, %{field: new_value})
      {:ok, %Streak{}}

      iex> update_streak(streak, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_streak(%Streak{} = streak, attrs) do
    streak
    |> Streak.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, streak} -> {:ok, Repo.preload(streak, :habit)}
      error -> error
    end
  end

  @doc """
  Deletes a streak.

  ## Examples

      iex> delete_streak(streak)
      {:ok, %Streak{}}

      iex> delete_streak(streak)
      {:error, %Ecto.Changeset{}}

  """
  def delete_streak(%Streak{} = streak) do
    Repo.delete(streak)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking streak changes.

  ## Examples

      iex> change_streak(streak)
      %Ecto.Changeset{source: %Streak{}}

  """
  def change_streak(%Streak{} = streak) do
    Streak.changeset(streak, %{})
  end
end
