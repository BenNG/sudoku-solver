defmodule Sudoku.ApplyValuesFast do

    @doc """
      We apply the given values to the map of possibilities with constraint propagation
      During this process, it's possible that new single values appears
      If it appended we recall run with the `new_values`

    """
    def run(map, values) do
        new_map = Enum.reduce(Map.keys(values), map, &(apply_value(&2, &1, Map.get(values, &1))))
        new_values = new_single_value_found(new_map, map)

        if Enum.empty?(new_values), do: new_map, else: run(new_map, new_values)
    end
    @doc """
    get the new key in map but only for length(values) === 1
    """
    def new_single_value_found(new_map, old_map) do
      new_map = new_map |> Sudoku.DataStructureUtils.filter_fixed_values
      old_map = old_map |> Sudoku.DataStructureUtils.filter_fixed_values
      Map.drop(new_map, Map.keys(old_map))
    end
    @doc """
    Will apply a value on the map and apply constraint on unit**s** that holds `tuple`
    """
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
end
