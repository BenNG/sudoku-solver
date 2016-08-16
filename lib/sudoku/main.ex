 defmodule Sudoku.Algo2 do
  # import Sudoku.Board
  # import Sudoku.Display
  # import Sudoku.Validation
  # import Sudoku.Strategies.NakedSingle
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
    Using Constraint Propagation
  """

  def run(input_str, output \\ :map) do
    # IO.inspect "starting with #{input_str}"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    initial_map = Sudoku.Board.init

    map = Sudoku.ApplyValues.run(initial_map, input_map)

    map = [
      fn(map) -> Sudoku.Strategies.NakedSingle.run(map)   end,
      fn(map) -> Sudoku.Backtracking.run(map) end,
    ]
    |> Enum.reduce_while(map, fn(strategy, acc) ->
      if Sudoku.Validation.is_complete?(acc), do: {:halt, acc}, else: {:cont, strategy.(acc) }
    end)

    if Sudoku.Validation.is_complete?(map) do
      case output do
        :map -> {:ok, map}
        :raw -> {:ok, Sudoku.DataStructureUtils.map_to_raw_data(map)}
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
        :raw -> {:error, Sudoku.DataStructureUtils.map_to_raw_data(map)}
      end
    end
  end

end
