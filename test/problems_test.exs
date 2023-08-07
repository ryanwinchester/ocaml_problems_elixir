defmodule ProblemsTest do
  use ExUnit.Case
  doctest Problems

  test "greets the world" do
    assert Problems.hello() == :world
  end
end
