defmodule Sudoku.Strategies.NakedSingle do
  @moduledoc """
  This module use the naked single strategy which look for an isolated cadidate in a unit (box, row, column)
  @example:
  If you look at the first row (row 0), you will the that the 6 is the only candidate left so we apply it
      | ------------------------------ | ------------------------------ | ------------------------------ |
      | 2         14579     579        | 49        8         149        | 3         157       1567       |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | ------------------------------ | ------------------------------ | ------------------------------ |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | ------------------------------ | ------------------------------ | ------------------------------ |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | 123456789 123456789 123456789  | 123456789 123456789 123456789  | 123456789 123456789 123456789  |
      | ------------------------------ | ------------------------------ | ------------------------------ |
  """

  def run(map) do
    values = Sudoku.Strategies.NakedSingle.do_run(map)
    map = Sudoku.ApplyValues.run(map, values)
    values = Sudoku.Strategies.NakedSingle.do_run(map)
    if Enum.empty?(values), do: map, else: run(map)
  end

  def do_run(map) do
    rows = Sudoku.Board.generate_rows
    cols = Sudoku.Board.generate_columns
    boxes = Sudoku.Board.generate_boxes

    Enum.reduce(1..9, %{}, fn(n, acc) ->
      ans3 = Enum.reduce([rows, cols, boxes], %{}, fn(items, acc) ->
        ans2 = Enum.reduce(items, %{}, fn(unit, acc) ->

          Map.merge(acc, search_for_naked_single_in_unit(map, unit, n))

        end)
        Map.merge(acc, ans2)
      end)
      Map.merge(acc, ans3)
    end)
  end

  defp search_for_naked_single_in_unit(map, unit, n) do
    seen = Enum.reduce(unit, %{}, fn(coord, acc) ->
      values = Map.get(map, coord)
      if Enum.member?(values, n) && length(values) > 1, do: Map.put(acc, coord, n), else: acc
    end)
    if length(Map.keys(seen)) === 1, do: seen, else: %{}
  end

end
