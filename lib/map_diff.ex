defmodule MapDiff do
  @moduledoc """
  Documentation for MapDiff.
  """
  def diff(a, b) when a == b and is_map(a), do: %{}
  def diff(a, b) when a == b and is_list(a), do: []
  def diff(a, b) when is_map(a) and is_map(b) do
    delta = Enum.reduce(a, %{}, &compare(&1, &2, b))
    additions(a, b, delta)
  end
  def diff(a, b) when is_list(a) and is_list(b) do
    delta = [a, b]
    |> Enum.zip
    |> Enum.reduce([], &compare(&1, &2))
    additions(a, b, delta)
  end

  def diff(a, nil), do: [a, nil]

  def diff(a, b) do
    raise ArgumentError, message: "MapDiff type changed"
    [a, b]
  end

  def compare({a_key, value_a} = a, delta, b) when is_map(value_a) do
    value_b = b |> Map.get(a_key)
    changes = diff(value_a, value_b)
    put_delta(delta, changes, a_key)
  end

  def put_delta(delta, result) when result == %{}, do: delta
  def put_delta(delta, result, _) when result == [], do: delta

  def put_delta(delta, result, key) when is_map(delta) do
    delta
    |> Map.put(key, result)
  end

  def put_delta(delta, result) when is_list(delta) do
    delta ++ [result]
  end

  def compare({a_key, value_a} = a, delta, b) when is_list(value_a) do
    value_b = b |> Map.get(a_key)
    changes = diff(value_a, value_b)
    put_delta(delta, changes, a_key)
  end

  def compare({a, b}, delta) when is_list(delta) do
    changes = diff(a, b)
    put_delta(delta, changes)
  end

  def compare({a_key, value_a} = a, delta, b) do
    value_b = b |> Map.get(a_key)
    if value_b != value_a do
      delta
      |> Map.put(a_key, [value_a, value_b])
    else
      delta
    end
  end

  def additions(a, b, delta) when is_map(a) do
    Enum.reduce(Map.keys(b) -- Map.keys(a), delta, fn(key, delta) ->
      raise ArgumentError, message: "MapDiff additions found in b"
    end)
  end

  def additions(a, b, delta) when is_list(a) do
    a_length = (Enum.count(a) - 1)
    new_in_b = b
    |> Enum.with_index
    |> Enum.filter(fn({value, index}) ->
      index > a_length
    end)
    |> Enum.map(fn({value, index}) ->
      value
    end)
    Enum.reduce(new_in_b, delta, fn(key, delta) ->
      raise ArgumentError, message: "MapDiff additions found in b"
    end)
  end
end
