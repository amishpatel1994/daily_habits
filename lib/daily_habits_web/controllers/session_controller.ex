defmodule DailyHabitsWeb.SessionController do
  use DailyHabitsWeb, :controller

  alias Plug.Conn
  alias DailtHabits.Auth.UserLogin
  alias Ecto.Changeset
  alias DailyHabitsWeb.ErrorHelpers

  @spec login(Conn.t(), UserLogin.t()) :: Conn.t()
  def login(conn, user_login) do
    with {:ok, conn} <- conn |> Pow.Plug.authenticate_user(user_login) do
      json(conn, %{token: conn.private[:api_access_token]})
    else
      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end

  @spec register(Conn.t(), UserRegistration.t()) :: Conn.t()
  def register(conn, user_registration_command) do
    with {:ok, _user, conn} <- conn |> Pow.Plug.create_user(user_registration_command) do
      json(conn, %{token: conn.private[:api_access_token]})
    else
      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
        conn
        |> put_status(500)
        |> json(%{error: %{status: 500, message: "Couldn't create user", errors: errors}})
    end
  end
end
