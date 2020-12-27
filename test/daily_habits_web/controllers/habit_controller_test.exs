defmodule DailyHabitsWeb.HabitControllerTest do
  use DailyHabitsWeb.ConnCase

  alias DailyHabits.Goal
  alias DailyHabits.Goal.Habit

  @create_attrs %{
    title: "some title"
  }
  @update_attrs %{
    title: "some updated title"
  }
  @invalid_attrs %{title: nil}

  def fixture(:habit) do
    {:ok, habit} = Goal.create_habit(@create_attrs)
    habit
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all habits", %{conn: conn} do
      conn = get(conn, Routes.habit_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create habit" do
    test "renders habit when data is valid", %{conn: conn} do
      conn = post(conn, Routes.habit_path(conn, :create), habit: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.habit_path(conn, :show, id))

      assert %{
               "id" => id,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.habit_path(conn, :create), habit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update habit" do
    setup [:create_habit]

    test "renders habit when data is valid", %{conn: conn, habit: %Habit{id: id} = habit} do
      conn = put(conn, Routes.habit_path(conn, :update, habit), habit: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.habit_path(conn, :show, id))

      assert %{
               "id" => id,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, habit: habit} do
      conn = put(conn, Routes.habit_path(conn, :update, habit), habit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete habit" do
    setup [:create_habit]

    test "deletes chosen habit", %{conn: conn, habit: habit} do
      conn = delete(conn, Routes.habit_path(conn, :delete, habit))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.habit_path(conn, :show, habit))
      end
    end
  end

  defp create_habit(_) do
    habit = fixture(:habit)
    {:ok, habit: habit}
  end
end
