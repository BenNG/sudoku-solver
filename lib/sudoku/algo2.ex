 defmodule Sudoku.Algo2 do
  # import Sudoku.Display
  # import Sudoku.Validation
  # import Sudoku.Strategies.NakedSingle
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

    if String.length(raw) !== 81, do: raise Sudoku.Backtracking.BadInputLength

    raw
    |> String.codepoints
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk(9,9)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({list, ord},acc) ->
      list
      |> Enum.with_index
      |> Enum.reduce(acc, fn({value, abs}, acc) ->
        if value !== 0, do: Map.put(acc, {abs, ord}, [value]), else: acc
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
    # IO.inspect "starting with #{raw}"
    input_values = input_to_map(raw)
    initial_map = initial_posibilities_to_map

    # test only
    # map = apply_values(initial_map, input_values, false)
    map = apply_values(initial_map, input_values)

    map = [
      fn(map) -> apply_isolated_values(map)   end,
      fn(map) -> Sudoku.Backtracking.run(map) end,
    ]
    |> Enum.reduce_while(map, fn(strategy, acc) ->
      if Sudoku.Validation.is_complete?(acc), do: {:halt, acc}, else: {:cont, strategy.(acc) }
    end)


    if Sudoku.Validation.is_complete?(map) do
      case output do
        :map -> {:ok, map}
        :raw -> {:ok, map_to_raw_data(map)}
      end
    else
      # IO.puts ""
      # IO.inspect ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      # IO.inspect "failed to solve #{raw}"
      # map |> Sudoku.Display.pretty
      # IO.inspect "#{(map |> Sudoku.DataStructureUtils.nbr_of_possibilities_left) - 81} extra values"
      # IO.inspect "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      # IO.puts ""
      case output do
        :map -> {:error, map}
        :raw -> {:error, map_to_raw_data(map)}
      end
    end
  end

  # debug only
  def apply_values(map, values, spread = false) do
      Enum.reduce(Map.keys(values), map, fn(key, acc) ->
        Map.put(acc, key, Map.get(values, key))
      end)
  end

  # We apply the given values to the map of possibilities
  # It possibly create new single values which values we can count on (like given values)
  def apply_values(map, values) do
      new_map = Enum.reduce(Map.keys(values), map, &(apply_value(&2, &1, Map.get(values, &1))))
      new_values = new_single_value_found(new_map, map)

      if Enum.empty?(new_values), do: new_map, else: apply_values(new_map, new_values)
  end

  def new_single_value_found(new_map, old_map) do
    new_map = new_map |> Sudoku.DataStructureUtils.filter_fixed_values
    old_map = old_map |> Sudoku.DataStructureUtils.filter_fixed_values
    Map.drop(new_map, Map.keys(old_map))
  end

  def apply_value(map, {abs, ord} = tuple, value) do
    value = if is_list(value), do: Enum.at(value, 0), else: value
    rows = Sudoku.Board.generate_row(ord) -- [tuple]
    columns = Sudoku.Board.generate_column(abs) -- [tuple]
    box = Sudoku.Board.generate_box(tuple) -- [tuple]

    map = Map.put(map, tuple, [value])

    rows ++ columns ++ box
    |> Enum.reduce(map, fn(coord, acc) ->
      values = Map.get(acc, coord) -- [value]
      Map.put(acc, coord, values)
    end)

  end

  def apply_isolated_values(map) do
    values = Sudoku.Strategies.NakedSingle.run(map)
    map = apply_values(map, values)
    values = Sudoku.Strategies.NakedSingle.run(map)
    if Enum.empty?(values), do: map, else: apply_isolated_values(map)
  end

end
