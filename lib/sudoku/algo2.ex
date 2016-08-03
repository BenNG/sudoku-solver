defmodule Sudoku.Algo2 do
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
    Using Constraint Propagation
  """

  @doc """
  Generate a map that represents the input

      "00600..."
      %{
        {2, 0} => 6
      }

  """
  def raw_data_to_map(raw) do

    if String.length(raw) !== 81, do: raise Sudoku.Algo1.BadInputLength

    raw
    |> String.codepoints
    |> Enum.map(&String.to_integer(&1))
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

  def map_to_raw_data(map) do
    order
    |> Enum.reduce("", fn(tuple, acc) ->
      acc <> (Map.get(map,tuple) |> Enum.at(0) |> Integer.to_string)
    end)
  end

  @doc """
  Generate possibilities

      "00600..."
      %{
        {0, 0} => [1,2,3,4,5,6,7,8,9],
        {1, 0} => [1,2,3,4,5,6,7,8,9],
        ...
      }

  """
  def initial_posibilities_to_map() do
    list = for  ord <- 0..8,
                abs <- 0..8,
                do: {{abs, ord}, Integer.digits(123456789)}
    Enum.reduce(list, %{}, fn({tuple, v},acc) -> Map.put(acc, tuple, v) end)
  end

  def order do
    for ord <- 0..8,
        abs <- 0..8,
        do: {abs, ord}
  end

  def pretty(map, display_coor \\ true) do
    IO.puts ""
    size_item = if display_coor, do: 16, else: 10

    draw_line(size_item)

    order
    |> Enum.chunk(27,27)
    |> Enum.each(fn(block) ->
      block
      |> Enum.chunk(9,9)
      |> Enum.each(fn(list) ->
          IO.write " | "
          Enum.chunk(list, 3,3)
          |> Enum.each(fn(items) ->
              Enum.each(items, fn(tuple) ->
                pretty_item(map, tuple, display_coor)
              end)
          IO.write " | "
          end)
          IO.puts ""
      end)

      draw_line(size_item)

    end)
  end

  def pretty_item(map, tuple, display_coor) do
    coor = if display_coor, do: String.pad_trailing("{#{elem(tuple,0)},#{elem(tuple,1)}}", 6), else: ""
    size_item = if display_coor, do: 16, else: 10
    v = Map.get(map, tuple)
    IO.write String.pad_trailing("#{coor}#{Enum.join(v)}", size_item)
  end

  def draw_line(size_item) do
    IO.write " | "
    0..2
    |> Enum.each(fn(_) ->
      0..2
      |> Enum.each(fn(_) ->
        String.duplicate("-", size_item) |> IO.write
      end)
      IO.write " | "
    end)
    IO.puts ""
  end

  def apply_value(map, {abs, ord} = tuple, value) do
    value = if is_list(value), do: Enum.at(value, 0), else: value
    rows = get_row_coordinates(ord) -- [tuple]
    columns = get_col_coordinates(abs) -- [tuple]
    box = get_box_coordinates(tuple) -- [tuple]

    map = Map.put(map, tuple, [value])

    rows ++ columns ++ box
    |> Enum.reduce(map, fn(coord, acc) ->
      values = Map.get(acc, coord) -- [value]
      Map.put(acc, coord, values)
    end)

  end

  def possible_values(map) do
    Map.values(map)
    |> Enum.reduce(0, fn(list,acc) ->
      acc + length(list)
    end)
  end

  def new_single_values(map, given_values) do
    Map.drop(map, Map.keys(given_values))
    |> Map.keys
    |> Enum.reduce([], fn(tuple, acc) ->
      if length(Map.get(map, tuple)) === 1, do: [tuple|acc], else: acc
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

  def run(raw) do
    given_values = raw_data_to_map(raw)
    apply_values(initial_posibilities_to_map, given_values, Map.keys(given_values))
  end

  # We apply the given values to the map of possibilities
  # It possibly create new single values which values we can count on (like given values)
  def apply_values(map, given_values, coords) do
      map = Enum.reduce(coords, map, &(apply_value(&2, &1, Map.get(given_values, &1))))
      news = new_single_values(map, given_values)

      do_apply_values(map, given_values, news)
  end
  # on recupere les valeurs qui sont dans la map par application des contraintes
  def do_apply_values(map, _, []), do: map
  def do_apply_values(map, given_values, coords) do
      map = Enum.reduce(coords, map, &(apply_value(&2, &1, Map.get(map, &1))))
      news = new_single_values(map, given_values)

      new_kind_of_given_values = Enum.reduce(coords, %{}, &(Map.put(&2, &1, Map.get(map, &1))))
      given_values = Map.merge(given_values, new_kind_of_given_values)

      do_apply_values(map, given_values, news)
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

end
