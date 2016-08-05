defmodule Sudoku.Loader do
  def load_file(filename) do
    {:ok, data } = File.read(filename)
    data
    |> String.replace("\n", "")
    |> String.split(~r/Grid\s\d{1,2}/)
    |> Enum.filter(&(String.length(&1) > 0))
  end
end
