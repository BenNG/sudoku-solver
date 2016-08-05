 defmodule Sudoku.Algo2 do
  import Sudoku.Display
  # import Sudoku.Validation
  # import Sudoku.Search
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
  def input_to_map(raw) do

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

  def run(raw, output \\ :map) do
    input_values = input_to_map(raw)
    initial_map = initial_posibilities_to_map

    map = compute(initial_map, input_values)

    if Enum.sum(Enum.map(Map.values(map), &length(&1))) === 81 do
      case output do
        :map -> {:ok, map}
        :debug -> {:ok, pretty(map)}
        :raw -> {:ok, map_to_raw_data(map)}
      end
    else
      case output do
        :map -> {:error, map}
        :debug ->
          IO.inspect "nbr of possibilities left: #{map |> Sudoku.DataStructureUtils.values_left}"
          IO.inspect(map, limit: :infinity)
          pretty(map)
        :raw -> {:error, map_to_raw_data(map)}
      end
    end
  end

  def compute(map, values) do
    map
    |> apply_values(values)
    |> apply_isolated_values
  end

  def run_file(filename) do
    Sudoku.Loader.load_file(filename)
    |> Enum.map(fn(raw) ->
      run(raw)
    end)
  end

  def resolve_euler_96 do
    run_file("./lib/sudoku/p096_sudoku.txt")
    |> Enum.reduce(0, fn(res, acc) ->
      acc + (String.slice(res, 0..2) |> String.to_integer)
    end)
  end

  # We apply the given values to the map of possibilities
  # It possibly create new single values which values we can count on (like given values)
  def apply_values(map, values) do
      new_map = Enum.reduce(Map.keys(values), map, &(apply_value(&2, &1, Map.get(values, &1))))
      new_values = new_values_found(new_map, map)

      if Enum.empty?(new_values), do: new_map, else: apply_values(new_map, new_values)
  end

  def new_values_found(new_map, old_map) do
    new_map = new_map |> Sudoku.DataStructureUtils.filter_fixed_values
    old_map = old_map |> Sudoku.DataStructureUtils.filter_fixed_values
    Map.drop(new_map, Map.keys(old_map))
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

  def apply_isolated_values(map) do
    values = Sudoku.Search.search_for_naked_single(map)
    map = apply_values(map, values)
    values = Sudoku.Search.search_for_naked_single(map)
    if Enum.empty?(values), do: map, else: apply_isolated_values(map)
  end

  def split_into_single_element(list) do
    Enum.reduce(list , [], fn({tuple, v}, acc) ->
      acc ++ Enum.map(v, fn(n) ->
        {tuple, n}
      end)
    end)
  end

end
