defmodule BadgeReaderTest do
  use ExUnit.Case
  doctest BadgeReader

  test "greets the world" do
    assert BadgeReader.hello() == :world
  end
end
