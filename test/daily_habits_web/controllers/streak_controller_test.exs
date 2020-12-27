defmodule DailyHabitsWeb.StreakControllerTest do
  use DailyHabitsWeb.ConnCase

  alias DailyHabits.Goal
  alias DailyHabits.Goal.Streak

  @create_attrs %{
    description: "some description",
    end_data: ~D[2010-04-17],
    start_date: ~D[2010-04-17]
  }
  @update_attrs %{
    description: "some updated description",
    end_data: ~D[2011-05-18],
    start_date: ~D[2011-05-18]
  }
  @invalid_attrs %{description: nil, end_data: nil, start_date: nil}

  def fixture(:streak) do
    {:ok, streak} = Goal.create_streak(@create_attrs)
    streak
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all streaks", %{conn: conn} do
      conn = get(conn, Routes.streak_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create streak" do
    test "renders streak when data is valid", %{conn: conn} do
      conn = post(conn, Routes.streak_path(conn, :create), streak: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.streak_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "end_data" => "2010-04-17",
               "start_date" => "2010-04-17"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.streak_path(conn, :create), streak: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update streak" do
    setup [:create_streak]

    test "renders streak when data is valid", %{conn: conn, streak: %Streak{id: id} = streak} do
      conn = put(conn, Routes.streak_path(conn, :update, streak), streak: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.streak_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "end_data" => "2011-05-18",
               "start_date" => "2011-05-18"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, streak: streak} do
      conn = put(conn, Routes.streak_path(conn, :update, streak), streak: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete streak" do
    setup [:create_streak]

    test "deletes chosen streak", %{conn: conn, streak: streak} do
      conn = delete(conn, Routes.streak_path(conn, :delete, streak))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.streak_path(conn, :show, streak))
      end
    end
  end

  defp create_streak(_) do
    streak = fixture(:streak)
    {:ok, streak: streak}
  end
end
