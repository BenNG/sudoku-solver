defmodule Sudoku.DataStructureUtils do

  def length_to_values(map) do
    map
    |> Map.to_list
    |> Enum.reduce(%{}, fn({_, v} = item, acc) ->
      Map.update(acc, length(v), [item], &([item|&1]))
    end)
  end

  def filter_fixed_values(map) do
      Enum.reduce(Map.keys(map), %{}, fn(key, acc) ->
        v = Map.get(map, key)
        if length(v) === 1, do: Map.put(acc, key, v), else: acc
      end)
  end

  def get_min_length_of_values(map) do
      Map.values(map)
      |> Enum.min_by(&(length(&1)))
      |> length
  end

  def filter_length_of_values(map,n) do
      Enum.reduce(Map.keys(map), %{}, fn(key, acc) ->
        v = Map.get(map, key)
        if length(v) === n, do: Map.put(acc, key, v), else: acc
      end)
  end

  def remove_fixed_values(map) do
      Enum.reduce(Map.keys(map), %{}, fn(key, acc) ->
        v = Map.get(map, key)
        if length(v) !== 1, do: Map.put(acc, key, v), else: acc
      end)
  end

  def values_left(map) do
    Map.values(map)
    |> Enum.reduce(0, fn(list,acc) ->
      acc + length(list)
    end)
  end

  def get_min_possibilities(map) do
    map = Sudoku.DataStructureUtils.length_to_values(map)
    if Enum.empty?(map) do
      []
    else
      min = Enum.min(Map.keys(map))
      Map.get(map, min)
    end
  end

end
