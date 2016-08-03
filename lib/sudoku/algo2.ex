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
    rows = Sudoku.Algo1.get_row_coordinates(ord) -- [tuple]
    columns = Sudoku.Algo1.get_col_coordinates(abs) -- [tuple]
    box = Sudoku.Algo1.get_box_coordinates(tuple) -- [tuple]

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

end
