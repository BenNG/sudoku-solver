defmodule Sudoku.Validation do
  def is_valid?(map) do
    false === map
    |> Map.values
    |> Enum.any?(&(Enum.empty?(&1)))
  end

  def is_complete?(map) do
    map
    |> Map.values
    |> Enum.all?(fn(list) -> length(list) === 1 end)
  end
end
