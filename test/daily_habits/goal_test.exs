defmodule DailyHabits.GoalTest do
  use DailyHabits.DataCase

  alias DailyHabits.Goal

  describe "habits" do
    alias DailyHabits.Goal.Habit

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def habit_fixture(attrs \\ %{}) do
      {:ok, habit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Goal.create_habit()

      habit
    end

    test "list_habits/0 returns all habits" do
      habit = habit_fixture()
      assert Goal.list_habits() == [habit]
    end

    test "get_habit!/1 returns the habit with given id" do
      habit = habit_fixture()
      assert Goal.get_habit!(habit.id) == habit
    end

    test "create_habit/1 with valid data creates a habit" do
      assert {:ok, %Habit{} = habit} = Goal.create_habit(@valid_attrs)
      assert habit.title == "some title"
    end

    test "create_habit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goal.create_habit(@invalid_attrs)
    end

    test "update_habit/2 with valid data updates the habit" do
      habit = habit_fixture()
      assert {:ok, %Habit{} = habit} = Goal.update_habit(habit, @update_attrs)
      assert habit.title == "some updated title"
    end

    test "update_habit/2 with invalid data returns error changeset" do
      habit = habit_fixture()
      assert {:error, %Ecto.Changeset{}} = Goal.update_habit(habit, @invalid_attrs)
      assert habit == Goal.get_habit!(habit.id)
    end

    test "delete_habit/1 deletes the habit" do
      habit = habit_fixture()
      assert {:ok, %Habit{}} = Goal.delete_habit(habit)
      assert_raise Ecto.NoResultsError, fn -> Goal.get_habit!(habit.id) end
    end

    test "change_habit/1 returns a habit changeset" do
      habit = habit_fixture()
      assert %Ecto.Changeset{} = Goal.change_habit(habit)
    end
  end

  describe "streaks" do
    alias DailyHabits.Goal.Streak

    @valid_attrs %{description: "some description", end_data: ~D[2010-04-17], start_date: ~D[2010-04-17]}
    @update_attrs %{description: "some updated description", end_data: ~D[2011-05-18], start_date: ~D[2011-05-18]}
    @invalid_attrs %{description: nil, end_data: nil, start_date: nil}

    def streak_fixture(attrs \\ %{}) do
      {:ok, streak} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Goal.create_streak()

      streak
    end

    test "list_streaks/0 returns all streaks" do
      streak = streak_fixture()
      assert Goal.list_streaks() == [streak]
    end

    test "get_streak!/1 returns the streak with given id" do
      streak = streak_fixture()
      assert Goal.get_streak!(streak.id) == streak
    end

    test "create_streak/1 with valid data creates a streak" do
      assert {:ok, %Streak{} = streak} = Goal.create_streak(@valid_attrs)
      assert streak.description == "some description"
      assert streak.end_data == ~D[2010-04-17]
      assert streak.start_date == ~D[2010-04-17]
    end

    test "create_streak/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goal.create_streak(@invalid_attrs)
    end

    test "update_streak/2 with valid data updates the streak" do
      streak = streak_fixture()
      assert {:ok, %Streak{} = streak} = Goal.update_streak(streak, @update_attrs)
      assert streak.description == "some updated description"
      assert streak.end_data == ~D[2011-05-18]
      assert streak.start_date == ~D[2011-05-18]
    end

    test "update_streak/2 with invalid data returns error changeset" do
      streak = streak_fixture()
      assert {:error, %Ecto.Changeset{}} = Goal.update_streak(streak, @invalid_attrs)
      assert streak == Goal.get_streak!(streak.id)
    end

    test "delete_streak/1 deletes the streak" do
      streak = streak_fixture()
      assert {:ok, %Streak{}} = Goal.delete_streak(streak)
      assert_raise Ecto.NoResultsError, fn -> Goal.get_streak!(streak.id) end
    end

    test "change_streak/1 returns a streak changeset" do
      streak = streak_fixture()
      assert %Ecto.Changeset{} = Goal.change_streak(streak)
    end
  end
end
