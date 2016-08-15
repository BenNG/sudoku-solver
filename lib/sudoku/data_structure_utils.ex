defmodule Sudoku.DataStructureUtils do

  @doc """
  Generate a map that represents the input

      "00600..."
      %{
        {2, 0} => 6
      }

  """
  def input_str_to_map(input_str) do
    l = String.length(input_str)
    if l !== 81, do: raise Sudoku.DataStructureUtils.BadInputLength
      Enum.reduce(0..(l-1), %{}, fn(n, acc) ->
      char = String.at(input_str, n)
      if char !== "0" do
        value = [String.to_integer(char)]
        Map.put(acc, {rem(n,9), div(n,9)}, value)
      else
        acc
      end
    end)
  end

  def map_to_raw_data(map) do
    Sudoku.Board.generate_rows
    |> List.flatten
    |> Enum.reduce("", fn(tuple, acc) ->
      acc <> (Map.get(map,tuple) |> Enum.at(0) |> Integer.to_string)
    end)
  end

  def map_to_stack(map) do
    Map.keys(map)
    |> Enum.reduce([], fn(coor, acc) ->
      [{coor, Map.get(map, coor)}|acc]
    end)
  end

  def stack_to_map(stack) do
    Enum.reduce(stack, %{}, fn({coor,v}, acc) ->
      v = if is_list(v), do: v, else: [v]
      Map.merge(acc, %{coor => v})
    end)
  end

  def length_to_values(map) do
    map
    |> Map.to_list
    |> Enum.reduce(%{}, fn({_, v} = item, acc) ->
      Map.update(acc, length(v), [item], &([item|&1]))
    end)
  end

  def filter_fixed_values(map) do
    filter_length_of_values(map, 1)
  end

  def filter_length_of_values(map,n) do
      Enum.reduce(Map.keys(map), %{}, fn(key, acc) ->
        v = Map.get(map, key)
        if length(v) === n, do: Map.put(acc, key, v), else: acc
      end)
  end

  def nbr_of_possibilities_left(map) do
    Enum.reduce(Map.values(map), 0 , &(&2 + length(&1)))
  end


  def map_to_list_of_fixed_values(map, coords) do
    map = Map.take(map, coords)
    fixed_map = Sudoku.DataStructureUtils.filter_fixed_values(map)
    values = Map.values(fixed_map)
  end


  defmodule BadInputLength do
    defexception []
    def message(_), do: "Please provide an input with 81 numbers"
  end

end
