defmodule Sudoku.Validation do
  def any_empty?(map) do
    map
    |> Map.values
    |> Enum.any?(&(Enum.empty?(&1)))
  end

  def is_valid?(map) do
    map
    |> Map.values
    |> Enum.all?(fn(list) -> length(list) === 1 end)
  end
end
