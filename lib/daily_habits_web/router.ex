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
  end

  scope "/", DailyHabitsWeb do
    pipe_through :browser

    get "/", PageController, :pwa
  end

  # Other scopes may use custom stacks.
  # scope "/api", DailyHabitsWeb do
  #   pipe_through :api
  # end
end
