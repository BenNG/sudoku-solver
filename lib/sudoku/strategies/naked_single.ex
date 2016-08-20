defmodule Sudoku.Strategies.NakedSingle do
  @moduledoc """
  This module use the naked single strategy which look for an isolated cadidate in a unit (box, row, column)
  An invokation could create new naked single values. If it is the case we apply the algorithm again
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

  @doc """
  run recursively the algorithm
  """
  def run(map) do
    alias Sudoku.ApplyValues

    values = do_run(map)
    map = ApplyValues.run(map, values)
    values = do_run(map)
    if Enum.empty?(values), do: map, else: run(map)
  end


  @doc """
  Look for an isolated cadidate in a unit (box, row, column)
  """
  def do_run(map) do
    Enum.reduce(1..9, %{}, fn(n, acc) ->
      Sudoku.Board.generate_units
      |> naked_single_in_units(n, map)
      |> Map.merge(acc)
    end)
  end

  defp naked_single_in_units(units, n, map) do
    Enum.reduce(units, %{}, fn(unit, acc) ->
      Map.merge(acc, naked_single_in_unit(unit, n, map))
    end)
  end

  @doc """
    inside a unit (row, col or box) find an isolated value that could be applied
  """
  defp naked_single_in_unit(unit, n, map) do
    seen = Enum.reduce(unit, %{}, fn(coord, acc) ->
      values = Map.get(map, coord)
      if Enum.member?(values, n) && length(values) > 1, do: Map.put(acc, coord, n), else: acc
    end)
    if length(Map.keys(seen)) === 1, do: seen, else: %{}
  end

end
