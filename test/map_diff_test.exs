defmodule MapDiffTest do
  use ExUnit.Case
  doctest MapDiff

  test "empty map when the same" do
    assert MapDiff.diff(%{a: 1, b: 2}, %{a: 1, b: 2}) == %{}
  end

  test "when top level map difference" do
    assert MapDiff.diff(%{a: 1, b: 1}, %{a: 1, b: 2}) == %{b: [1, 2]}
  end

  test "when top level map missing key" do
    assert MapDiff.diff(%{a: 1, b: 1}, %{a: 1}) == %{b: [1, nil]}
  end
end
