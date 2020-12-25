defmodule Powjwt.Users.UserLogin do
  defstruct [:email, :password]

  @type t() :: %__MODULE__{}
end
