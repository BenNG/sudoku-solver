defmodule Sudoku.Algo1 do
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
  """
  def times(a,b), do: a*b
  @doc """
  Generate a map that represents the input sudoku

      "00600..."
      %{
        {2, 0} => 6
      }

  """
  def create_built_in_values(data) do

    if String.length(data) !== 81, do: raise Sudoku.Algo1.BadInputLength

    data
    |> String.codepoints
    |> Enum.map(fn(x) -> String.to_integer(x) end)
    |> Enum.chunk(9,9)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({list, ord},acc) ->
      list
      |> Enum.with_index
      |> Enum.reduce(acc, fn({value, abs}, acc) ->
        if value !== 0, do: Map.put(acc, {abs, ord}, value), else: acc
      end)
    end)
  end

  defmodule BadInputLength do
    defexception []
    def message(_), do: "Please provide an input with 81 codepoints"
  end

  @doc """
  generate coordinates for columns
      [[{0,0},{0,1},{0,2},{0,3},{0,4},{0,5},{0,6},{0,7},{0,8},],...]
  """
  def create_cols(size \\ 9) do
    Enum.reduce(0..size - 1, [], fn(abs,acc) ->
      col = Enum.reduce(0..size - 1, [], fn(ord, accu) ->
        [{abs,ord}|accu]
      end)
      |> Enum.reverse
      [col | acc]
    end)
    |> Enum.reverse
  end

  @doc """
  generate coordinates for rows
      [[{0,0},{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0},{8,0},],...]
  """
  def create_rows(size \\ 9) do
    Enum.reduce(0..size - 1, [], fn(ord,acc) ->
      col = Enum.reduce(0..size - 1, [], fn(abs, accu) ->
        [{abs,ord}|accu]
      end)
      |> Enum.reverse
      [col | acc]
    end)
    |> Enum.reverse
  end

  @doc """
  generate coordinates for boxes
      [[{0,0},{0,1},{0,2},{1,0},{1,1},{1,2},{2,0},{2,1},{2,2}],...]
  """
  def create_boxes(size \\ 3) do
    range = Enum.slice([0..2, 3..5, 6..8], 0..size - 1 )

    Enum.reduce(range, [], fn(r_ord,acc) ->
      col_boxes = Enum.reduce(range, [], fn(r_abs, accu) ->
        comp = for x <- r_abs,
                   y <- r_ord,
                   do: {x,y}
        [comp | accu]
      end)
      |> Enum.reverse
      acc ++ col_boxes
    end)
  end

  @doc """
  Return coordinates of the box
      {5,5} -> [{3,3},{3,4},{3,5},{4,3},{4,4},{4,5},{5,3},{5,4},{5,5}]
  """
  def get_box_coordinates(tuple) do
    Enum.find(create_boxes, fn(boxe) ->
      Enum.member?(boxe, tuple)
    end)
  end

  @doc """
  Return coordinates of the column
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_col_coordinates(col_num) do
    Enum.at(create_cols, col_num)
  end

  @doc """
  Return coordinates of the row
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_row_coordinates(row_num) do
    Enum.at(create_rows, row_num)
  end

  @doc """
  Return values of the row
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_row(row_num, stack, built_in_map) do
    coordinates = get_row_coordinates(row_num)
    stack_values = filter_stack_by_coordinates(stack, coordinates)
    built_in_values = built_in_values_to_stack_structure(built_in_map, coordinates)

    Enum.sort(merge_uniq(stack_values, built_in_values), fn({{abs1,_},_},{{abs2,_},_}) -> abs1 < abs2 end)
  end

  @doc """
  Return coordinates of the col
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_col(col_num, stack, built_in_map) do
    coordinates = get_col_coordinates(col_num)
    stack_values = filter_stack_by_coordinates(stack, coordinates)
    built_in_values = built_in_values_to_stack_structure(built_in_map, coordinates)

    Enum.sort(merge_uniq(stack_values, built_in_values), fn({{_,ord1},_},{{_,ord2},_}) -> ord1 < ord2 end)
  end

  @doc """
  Return coordinates of the box
      {3,1} -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_box(tuple, stack, built_in_map) do
    coordinates = get_box_coordinates(tuple)
    stack_values = filter_stack_by_coordinates(stack, coordinates)
    built_in_values = built_in_values_to_stack_structure(built_in_map, coordinates)

    Enum.sort(merge_uniq(stack_values, built_in_values), fn({{abs1,ord1},_},{{abs2,ord2},_}) ->
      if abs1 === abs2, do: ord1 < ord2, else: abs1 < abs2
    end)
  end

  @doc """
  Check if a row is valid
  """
  def is_row_valid?(row_num, stack, built_in_values) do
    values = get_row(row_num, stack, built_in_values) |> get_values
    Enum.sort(values) === Enum.dedup(Enum.sort(values))
  end

  @doc """
  Check if all rows are valid
  """
  def is_rows_valid?(stack, built_in_values) do
    [true] === Enum.map(0..8, fn(row_num) ->
      is_row_valid?(row_num, stack, built_in_values)
    end)
    |> Enum.dedup
  end

  @doc """
  Check if a column is valid
  """
  def is_col_valid?(col_num, stack, built_in_values) do
    values = get_col(col_num, stack, built_in_values) |> get_values
    Enum.sort(values) === Enum.dedup(Enum.sort(values))
  end

  @doc """
  Check if all columns are valid
  """
  def is_cols_valid?(stack, built_in_values) do
    [true] === Enum.map(0..8, fn(col_num) ->
      is_col_valid?(col_num, stack, built_in_values)
    end)
    |> Enum.dedup
  end

  @doc """
  Check if a box is valid
  """
  def is_box_valid?(tuple, stack, built_in_values) do
    values = get_box(tuple, stack, built_in_values) |> get_values
    Enum.sort(values) === Enum.dedup(Enum.sort(values))
  end

  @doc """
  check if the entire sudoku is valid
  """
  def is_valid?(stack, built_in_values) do
    rows = Enum.map(0..8, fn(row_num) ->
      is_row_valid?(row_num, stack, built_in_values)
    end)

    cols = Enum.map(0..8, fn(col_num) ->
      is_col_valid?(col_num, stack, built_in_values)
    end)

    boxes = Enum.map(0..8, fn(num) ->
      is_box_valid?({num,num}, stack, built_in_values)
    end)

    length(merge_uniq(stack, built_in_values)) === 81 &&
    [true] === Enum.dedup(rows) &&
    [true] === Enum.dedup(cols) &&
    [true] === Enum.dedup(boxes)

  end



  # ###########################################################################
  # private

  @doc """
  extract values from the stack
  """
  defp get_values(list_of_tuple) do
    list_of_tuple
    |> Enum.map(fn({_,v}) ->
      v
    end)
  end

  @doc """
  extract tuples from the stack
  """
  defp get_tuples(list_of_tuple) do
    list_of_tuple
    |> Enum.map(fn({tuple,v}) ->
      tuple
    end)
  end

  defp filter_stack_by_coordinates(stack, list_of_tuple) do
    Enum.filter(stack, fn({tuple,_} = item) ->
      Enum.member?(list_of_tuple, tuple)
    end)
  end
  @doc """
  transform and filter built_in_map to have the same structure as stack
  """
  defp built_in_values_to_stack_structure(built_in_map, coordinates) do
    Enum.reduce(coordinates, [], fn(tuple,acc) ->
      if (v = Map.get(built_in_map, tuple)) !== nil, do: [{tuple,v}|acc], else: acc
    end)
  end

  @doc """
  put item that is not already in the stack
  """
  def merge_uniq(stack, items) do
    stack ++ Enum.reduce(items, [], fn({tuple,v} = item,acc) ->
      if Enum.member?(get_tuples(stack), tuple), do: acc, else: [item|acc]
    end)
  end


  def add([], built_in_values) do
    if (v = Map.get(built_in_values, {0,0})) !== nil do
      add([{{0,0}, v}], built_in_values)
    else
      [{{0,0}, 0}]
    end
  end
  def add(stack, built_in_values) do
    [h|t] = stack
    coor = get_next_coordonates(h)

    if (v = Map.get(built_in_values, coor)) !== nil do
      add([{coor, v}|stack], built_in_values)
    else
      [{coor, 0}|stack]
    end

  end

  def get_next_coordonates({{8,8},_}), do: raise Sudoku.Algo1.LastElement
  def get_next_coordonates({{8 = abs,ord},v}), do: {0, ord + 1}
  def get_next_coordonates({{abs, ord},v}), do: {abs + 1, ord}

  def increase([]), do: raise Sudoku.Algo1.IncreaseEmptyStack
  def increase([{tuple, 9}|t]), do: :drop
  def increase([{tuple, v}|t]) do
    [{tuple, v + 1} |t]
  end


  defmodule LastElement do
    defexception []
    def message(_), do: "{8,8} is the latest element"
  end

  defmodule IncreaseEmptyStack do
    defexception []
    def message(_), do: "Could not increase an empty stack"
  end

end
