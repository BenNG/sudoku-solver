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
  generate all the rows coordinates
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
  generate all the boxes coordinates
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
  return the linked boxe given a tuple
      {5,5} -> [{3,3},{3,4},{3,5},{4,3},{4,4},{4,5},{5,3},{5,4},{5,5}]
  """
  def get_box_coordinates(tuple) do
    Enum.find(create_boxes, fn(boxe) ->
      Enum.member?(boxe, tuple)
    end)
  end

  @doc """
  return the linked col given col number
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_col_coordinates(col_num) do
    Enum.at(create_cols, col_num)
  end

  @doc """
  return the linked row given row number
      3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  """
  def get_row_coordinates(row_num) do
    Enum.at(create_rows, row_num)
  end

end
