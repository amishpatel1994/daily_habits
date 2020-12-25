defmodule DailyHabitsWeb.PageView do
  use DailyHabitsWeb, :view

  def render("pwa.html", _assigns) do
    Path.join(:code.priv_dir(:daily_habits), "static/build/index.html")
    |> File.read!()
    |> raw()
  end
end
