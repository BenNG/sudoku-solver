defmodule Sudoku.Algo1 do
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
  """
  def times(a,b), do: a*b
  @doc """
  given a string of 81 codepoints, it returns a map

      "00600..."
      %{
        {2, 0} => 6
      }

  """
  def create_built_in_map(data) do

    if String.length(data) !== 81, do: raise Sudoku.Algo1.BadInputLength

    data
    |> String.codepoints
    |> Enum.chunk(9,9)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({list, ord},acc) ->
      list
      |> Enum.with_index
      |> Enum.reduce(acc, fn({value, abs}, acc) ->
        if value !== "0", do: Map.put(acc, {abs, ord}, value), else: acc
      end)
    end)
  end

  defmodule BadInputLength do
    defexception []
    def message(_), do: "Please provide an input with 81 codepoints"
  end

  @doc """
  generate all the cols coordinates
      [{0,0},{0,1},{0,2},{0,3},{0,4},{0,5},{0,6},{0,7},{0,8},],...
  """
  def create_cols do
    Enum.reduce(0..8, [], fn(abs,acc) ->
      col = Enum.reduce(0..8, [], fn(ord, accu) ->
        [{abs,ord}|accu]
      end)
      |> Enum.reverse
      [col | acc]
    end)
    |> Enum.reverse
  end

  @doc """
  generate all the rows coordinates
      [{0,0},{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0},{8,0},],...
  """
  def create_rows do
    Enum.reduce(0..8, [], fn(ord,acc) ->
      col = Enum.reduce(0..8, [], fn(abs, accu) ->
        [{abs,ord}|accu]
      end)
      |> Enum.reverse
      [col | acc]
    end)
    |> Enum.reverse
  end

end
