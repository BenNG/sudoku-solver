defmodule Sudoku.Backtracking do
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
    Using all the possibilities
    End now
  """

  def map_to_stack(map) do
    Map.keys(map)
    |> Enum.reduce([], fn(coor, acc) ->
      [{coor, Map.get(map, coor)}|acc]
    end)
  end

  def stack_to_map(stack) do
    Enum.reduce(stack, %{}, fn({coor,v}, acc) ->
      Map.merge(acc, %{coor => v})
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
  def generate_board_columns(size \\ 9) do
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
  def generate_board_rows(size \\ 9) do
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
  def generate_board_boxes(size \\ 3) do
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
    Enum.find(generate_board_boxes, fn(boxe) ->
      Enum.member?(boxe, tuple)
    end)
  end

  @doc """
  Return coordinates of the column
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_col_coordinates(col_num) do
    Enum.at(generate_board_columns, col_num)
  end

  @doc """
  Return coordinates of the row
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_row_coordinates(row_num) do
    Enum.at(generate_board_rows, row_num)
  end

  @doc """
  Return values of the row
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_row(row_num, stack, built_in_map) do
    coordinates = get_row_coordinates(row_num)
    stack_values = filter_stack_by_coordinates(stack, coordinates)
    built_in_values = built_in_values_to_stack_structure(built_in_map, coordinates)

    Enum.sort(merge_uniq(stack_values, built_in_values), fn({{abs1,_},_},{{abs2,_},_}) -> abs1 < abs2 end)  end

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
  def is_complete?(stack, built_in_values) do
    rows = Enum.map(0..8, fn(row_num) ->
      is_row_valid?(row_num, stack, built_in_values)
    end)

    cols = Enum.map(0..8, fn(col_num) ->
      is_col_valid?(col_num, stack, built_in_values)
    end)

    boxes = Enum.map(0..8, fn(num) ->
      is_box_valid?({num,num}, stack, built_in_values)
    end)

    [true] === Enum.dedup(rows) &&
    [true] === Enum.dedup(cols) &&
    [true] === Enum.dedup(boxes)

  end

  def run(map, output \\ :map) do
    # IO.inspect "starting 1 ... with"
    # IO.inspect "nbr of possibilities left: #{map |> Sudoku.DataStructureUtils.values_left}"
    # map |> Sudoku.Display.pretty
    Agent.start(fn -> map end, name: MV)

    moving_coords = Sudoku.Algo2.order -- Map.keys(Sudoku.DataStructureUtils.filter_fixed_values(map))

    # IO.inspect "moving_coords: #{inspect moving_coords}"

    stack = add([], moving_coords, map)
    map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
    # map |> Sudoku.Display.pretty
    do_run(stack, moving_coords, map, output, 0)
  end

  def do_run(stack, moving_coords, map, output, count) do

    if count === 30, do: raise "count === #{count}"

    if Sudoku.Validation.is_valid?(map) === false do
      if Sudoku.Validation.is_complete?(map) do
        # IO.inspect "c'est bon !"
        Agent.stop(MV)
        case output do
          :map -> map
          :raw -> Sudoku.Algo2.map_to_raw_data(map)
        end
      else
        # IO.inspect "valid: add"
        stack = add(stack, moving_coords, map)
        # IO.inspect "stack is now: #{inspect stack}"
        map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
        # map |> Sudoku.Display.pretty

        do_run(stack, moving_coords, map, output, count + 1)
      end
    else
      if is_last_value_to_test?(stack, Agent.get(MV, &(&1))) do
        # IO.inspect "not valid: drop"
        stack = drop(stack, map)
        # IO.inspect "stack is now: #{inspect stack}"
        stack = increase(stack, moving_coords, Agent.get(MV, &(&1)))
        map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
        do_run(stack, moving_coords, map, output, count + 1)
      else
        # IO.inspect "not valid: increase"
        stack = increase(stack, moving_coords, Agent.get(MV, &(&1)))
        map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
        do_run(stack, moving_coords, map, output, count + 1)
      end
    end
  end

  def apply_stack_to_map(stack, map) do
    Sudoku.Algo2.compute(map, stack_to_map(stack))
  end

  def is_last_value_to_test?([], _), do: raise Sudoku.Backtracking.EmptyStack
  def is_last_value_to_test?([{coor,v}|_], map) do
    mv = Map.get(map, coor)
    index = Enum.find_index(mv, fn(x) -> x == v end)
    bool = index === length(mv) - 1
    # IO.inspect "last value for : #{inspect {coor, v}} --> #{bool}"
    if bool, do: true, else: false
  end

  def add([], [coor|_] = _, map) do
    values = Map.get(map, coor)
    v = Enum.fetch!(values, 0)
    # IO.inspect "adding: #{inspect {coor, v}}"
    [{coor, v}]
  end

  def add([h|_] = stack, moving_coords, map) do
    index = Enum.find_index(moving_coords, fn(x) -> x == elem(h,0) end)
    coor = Enum.fetch!(moving_coords, index + 1)
    values = Map.get(map, coor)
    v = Enum.fetch!(values, 0)
    # IO.inspect "adding: #{inspect {coor, v}}"
    [{coor, v}|stack]
  end

  @doc """
  extract values from the stack
  """
  def get_values(list_of_tuple) do
    list_of_tuple
    |> Enum.map(fn({_,v}) ->
      v
    end)
  end

  @doc """
  extract tuples from the stack
  """
  def get_tuples(list_of_tuple) do
    list_of_tuple
    |> Enum.map(fn({tuple,_}) ->
      tuple
    end)
  end

  defp filter_stack_by_coordinates(stack, list_of_tuple) do
    Enum.filter(stack, fn({tuple,_}) ->
      Enum.member?(list_of_tuple, tuple)
    end)
  end
  @doc """
  transform and filter built_in_map to have the same structure as stack
  """
  def built_in_values_to_stack_structure(built_in_map, coordinates) do
    Enum.reduce(coordinates, [], fn(tuple,acc) ->
      if (v = Map.get(built_in_map, tuple)) !== nil, do: [{tuple,v}|acc], else: acc
    end)
  end

  @doc """
  put item that is not already in the stack
  """
  def merge_uniq(stack, items) do
    stack ++ Enum.reduce(items, [], fn({tuple,_} = item,acc) ->
      if Enum.member?(get_tuples(stack), tuple), do: acc, else: [item|acc]
    end)
  end

  def get_next_coordonates({{8,8},_}), do: raise Sudoku.Backtracking.LastElement
  def get_next_coordonates({{8 = _,ord},_}), do: {0, ord + 1}
  def get_next_coordonates({{abs, ord},_}), do: {abs + 1, ord}

  def increase([], _, _), do: raise Sudoku.Backtracking.EmptyStack
  def increase([{coor, v}|t], _, map) do
    values = Map.get(map, coor)
    index = Enum.find_index(values, fn(x) -> x == v end)
    if index === length(values) - 1 do
      raise Sudoku.Backtracking.EndOfElements
    else
      new_v = Enum.fetch!(values, index + 1)
      # IO.inspect "increase from #{inspect {coor, v} } to #{inspect {coor, new_v} }"
      [{coor, new_v}|t]
    end
  end

  def drop([], _), do: raise Sudoku.Backtracking.EmptyStack
  def drop([_h|t] = stack, map) do
    # IO.inspect "droping: #{inspect _h}"
    # IO.inspect "stack: #{inspect stack}"
    if is_last_value_to_test?(t, Agent.get(MV, &(&1))) do
      drop(t, map)
    else
      t
    end
  end

  defmodule EndOfElements do
    defexception []
    def message(_), do: "No more values, you probably have to drop the element"
  end

  defmodule LastElement do
    defexception []
    def message(_), do: "{8,8} is the latest element"
  end

  defmodule EmptyStack do
    defexception []
    def message(_), do: "Could not operate on empty stack"
  end

end
