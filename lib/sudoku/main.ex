defmodule Sudoku.Main do
  @moduledoc """
  This module will run the sudoku against our strategies
  """

  def run(input_str) do
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)

    strategies = [
      fn(map) -> Sudoku.Strategies.NakedSingle.run(map)   end,
      fn(map) -> Sudoku.Backtracking.run(map)             end,
    ]

    map = Enum.reduce_while(strategies, map, fn(strategy, acc) ->
      if Sudoku.Validation.is_complete?(acc), do: {:halt, acc}, else: {:cont, strategy.(acc) }
    end)

    if Sudoku.Validation.is_complete?(map), do: {:ok, map}, else: {:error, map}
  end

end
