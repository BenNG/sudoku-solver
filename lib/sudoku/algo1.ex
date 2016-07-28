defmodule Sudoku.Algo1 do
  def times(a,b), do: a*b
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

end
