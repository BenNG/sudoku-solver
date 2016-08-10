 defmodule Sudoku.Algo2 do
  # import Sudoku.Board
  # import Sudoku.Display
  # import Sudoku.Validation
  # import Sudoku.Strategies.NakedSingle
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
    Using Constraint Propagation
  """

  @doc """
  Generate a map that represents the input

      "00600..."
      %{
        {2, 0} => 6
      }

  """
  def input_to_map(raw) do
    l = String.length(raw)
    if l !== 81, do: raise Sudoku.Backtracking.BadInputLength
    0..(l-1)
    |> Enum.reduce(%{}, fn(n, acc) ->
      v = String.at(raw, n)
      if v !== "0", do: Map.put(acc, {rem(n,9), div(n,9)}, [String.to_integer(v)] ), else: acc
    end)
  end

  def map_to_raw_data(map) do
    Sudoku.Board.generate_rows
    |> List.flatten
    |> Enum.reduce("", fn(tuple, acc) ->
      acc <> (Map.get(map,tuple) |> Enum.at(0) |> Integer.to_string)
    end)
  end

  def run(raw, output \\ :map) do
    # IO.inspect "starting with #{raw}"
    input_values = input_to_map(raw)
    initial_map = Sudoku.Board.init

    # test only
    # map = apply_values(initial_map, input_values, false)
    map = Sudoku.ApplyValues.run(initial_map, input_values)

    map = [
      fn(map) -> apply_isolated_values(map)   end,
      fn(map) -> Sudoku.Backtracking.run(map) end,
    ]
    |> Enum.reduce_while(map, fn(strategy, acc) ->
      if Sudoku.Validation.is_complete?(acc), do: {:halt, acc}, else: {:cont, strategy.(acc) }
    end)


    if Sudoku.Validation.is_complete?(map) do
      case output do
        :map -> {:ok, map}
        :raw -> {:ok, map_to_raw_data(map)}
      end
    else
      # IO.puts ""
      # IO.inspect ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      # IO.inspect "failed to solve #{raw}"
      # map |> Sudoku.Display.pretty
      # IO.inspect "#{(map |> Sudoku.DataStructureUtils.nbr_of_possibilities_left) - 81} extra values"
      # IO.inspect "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      # IO.puts ""
      case output do
        :map -> {:error, map}
        :raw -> {:error, map_to_raw_data(map)}
      end
    end
  end

  def apply_isolated_values(map) do
    values = Sudoku.Strategies.NakedSingle.run(map)
    map = Sudoku.ApplyValues.run(map, values)
    values = Sudoku.Strategies.NakedSingle.run(map)
    if Enum.empty?(values), do: map, else: apply_isolated_values(map)
  end

end
