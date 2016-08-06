defmodule Sudoku.DataStructureUtils do

  def map_to_stack(map) do
    Map.keys(map)
    |> Enum.reduce([], fn(coor, acc) ->
      [{coor, Map.get(map, coor)}|acc]
    end)
  end

  def stack_to_map(stack) do
    Enum.reduce(stack, %{}, fn({coor,v}, acc) ->
      Map.merge(acc, %{coor => v})
    end)
  end

  def length_to_values(map) do
    map
    |> Map.to_list
    |> Enum.reduce(%{}, fn({_, v} = item, acc) ->
      Map.update(acc, length(v), [item], &([item|&1]))
    end)
  end

  def filter_fixed_values(map) do
    filter_length_of_values(map, 1)
  end

  def filter_length_of_values(map,n) do
      Enum.reduce(Map.keys(map), %{}, fn(key, acc) ->
        v = Map.get(map, key)
        if length(v) === n, do: Map.put(acc, key, v), else: acc
      end)
  end

  def nbr_of_possibilities_left(map) do
    Enum.reduce(Map.values(map), 0 , &(&2 + length(&1)))
  end

end
