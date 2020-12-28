defmodule DailyHabitsWeb.Router do
  use DailyHabitsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DailyHabits.Users.AuthFlow, otp_app: :daily_habits
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: DailyHabitsWeb.AuthErrorHandler
  end

  scope "/", DailyHabitsWeb do
    pipe_through :browser

    get "/", PageController, :pwa
  end

  scope "/api/auth", DailyHabitsWeb do
    pipe_through :api
    post "/login", SessionController, :login
    post "/register", SessionController, :register
  end

  scope "/api", DailyHabitsWeb do
    pipe_through [:api, :api_protected]
    get "/profile", TestController, :show
    get "/streaks", StreakController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DailyHabitsWeb do
  #   pipe_through :api
  # end
end
