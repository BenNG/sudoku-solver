defmodule Sudoku.Search do

  def search_for_naked_single(map) do
    rows = Sudoku.Backtracking.generate_board_rows
    cols = Sudoku.Backtracking.generate_board_columns
    boxes = Sudoku.Backtracking.generate_board_boxes

    Enum.reduce(1..9, %{}, fn(n, acc) ->
      ans3 = Enum.reduce([rows, cols, boxes], %{}, fn(items, acc) ->
        ans2 = Enum.reduce(items, %{}, fn(unit, acc) ->

          Map.merge(acc, Sudoku.Search.search_for_naked_single_in_unit(map, unit, n))

        end)
        Map.merge(acc, ans2)
      end)
      Map.merge(acc, ans3)
    end)
  end

  def search_for_naked_single_in_unit(map, unit, n) do
    seen = Enum.reduce(unit, %{}, fn(coord, acc) ->
      values = Map.get(map, coord)
      if Enum.member?(values, n) && length(values) > 1, do: Map.put(acc, coord, n), else: acc
    end)
    if length(Map.keys(seen)) === 1, do: seen, else: %{}
  end

end
