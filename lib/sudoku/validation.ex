defmodule Sudoku.Validation do
  def any_empty_values?(map) do
    map
    |> Map.values
    |> Enum.any?(&(Enum.empty?(&1)))
  end

  def is_complete?(map) do
    map
    |> Map.values
    |> Enum.all?(fn(list) -> length(list) === 1 end)
  end



  @doc """
  Check if a row is valid
  """
  def is_row_valid?(n, map) do
    coords = Sudoku.Board.generate_row(n)
    values = map_to_list_of_fixed_values(map, coords)
    is_valid_unit?(values)
  end

  def is_valid_unit?(list) do
    Enum.sort(list) === Enum.dedup(Enum.sort(list))
  end

  def map_to_list_of_fixed_values(map, coords) do
    map = Map.take(map, coords)
    fixed_map = Sudoku.DataStructureUtils.filter_fixed_values(map)
    values = Map.values(fixed_map)
  end

  # @doc """
  # Check if all rows are valid
  # """
  def is_rows_valid?(map) do
    [true] === Enum.map(0..8, fn(n) ->
      is_row_valid?(n, map)
    end)
    |> Enum.dedup
  end

  # @doc """
  # Check if a column is valid
  # """
  def is_column_valid?(n, map) do
    coords = Sudoku.Board.generate_column(n)
    values = map_to_list_of_fixed_values(map, coords)
    is_valid_unit?(values)
  end
  #
  # @doc """
  # Check if all columns are valid
  # """
  def is_columns_valid?(map) do
    [true] === Enum.map(0..8, fn(n) ->
      is_column_valid?(n, map)
    end)
    |> Enum.dedup
  end
  #
  # @doc """
  # Check if a box is valid
  # """
  def is_box_valid?(n, map) do
    coords = Sudoku.Board.generate_box(n)
    values = map_to_list_of_fixed_values(map, coords)
    is_valid_unit?(values)
  end
  @doc """
  # Check if all boxes are valid
  """
  def is_boxes_valid?(map) do
    [true] === Enum.map(0..8, fn(n) ->
      is_box_valid?(n, map)
    end)
    |> Enum.dedup
  end

  @doc """
  check if the entire sudoku is valid
  """
  def is_valid?(map) do
    rows = Enum.map(0..8, fn(n) ->
      is_row_valid?(n, map)
    end)

    cols = Enum.map(0..8, fn(n) ->
      is_column_valid?(n, map)
    end)

    boxes = Enum.map(0..8, fn(n) ->
      is_box_valid?(n, map)
    end)

    [true] === Enum.dedup(rows) &&
    [true] === Enum.dedup(cols) &&
    [true] === Enum.dedup(boxes) &&
    any_empty_values?(map) === false

  end
end
