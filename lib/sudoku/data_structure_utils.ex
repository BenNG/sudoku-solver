defmodule Sudoku.DataStructureUtils do
  def length_to_values(map) do
    map
    |> Map.to_list
    |> Enum.reduce(%{}, fn({_, v} = item, acc) ->
      Map.update(acc, length(v), [item], &([item|&1]))
    end)
  end
end
