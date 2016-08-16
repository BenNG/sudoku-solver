defmodule Sudoku.File do
  def run_file(filename) do
    Sudoku.Loader.load_file(filename)
    |> Enum.map(fn(input_str) ->
      {:ok, result} = Sudoku.Main.run(input_str)
      result
      |> Sudoku.DataStructureUtils.map_to_input_str
    end)
  end

  def resolve_euler_96 do
    run_file("./lib/sudoku/p096_sudoku.txt")
    |> Enum.reduce(0, fn(res, acc) ->
      acc + (String.slice(res, 0..2) |> String.to_integer)
    end)
  end
end
