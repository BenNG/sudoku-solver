defmodule Sudoku.Validation do

  @doc """
  check if the entire sudoku is valid
  """
  def is_valid?(map) do
    bool = Enum.reduce_while(0..8, false, fn(n,acc) ->
      if is_row_valid?(n, map) && is_column_valid?(n, map) && is_box_valid?(n, map) do
        {:cont, true}
      else
        {:halt, false}
      end
    end)

    bool &&
    any_empty_values?(map) === false
  end

  def any_empty_values?(map) do
    map
    |> Map.values
    |> Enum.any?(&(Enum.empty?(&1)))
  end

  def is_complete?(map) do
    map
    |> Map.values
    |> Enum.all?(&(length(&1) === 1))
  end

  @doc """
  Check if a row is valid
  """
  def is_row_valid?(n, map) do
    coords = Sudoku.Board.generate_row(n)
    values = Sudoku.DataStructureUtils.map_to_list_of_fixed_values(map, coords)
    is_valid_unit?(values)
  end

  # @doc """
  # Check if a column is valid
  # """
  def is_column_valid?(n, map) do
    coords = Sudoku.Board.generate_column(n)
    values = Sudoku.DataStructureUtils.map_to_list_of_fixed_values(map, coords)
    is_valid_unit?(values)
  end

  def is_box_valid?(n, map) do
    coords = Sudoku.Board.generate_box(n)
    values = Sudoku.DataStructureUtils.map_to_list_of_fixed_values(map, coords)
    is_valid_unit?(values)
  end

  @doc """
  return true if the unit (row, column, box) has no duplicate it may or may not be complete though
  """
  def is_valid_unit?(list) do
    Enum.sort(list) === Enum.dedup(Enum.sort(list))
  end

end
