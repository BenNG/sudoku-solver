defmodule Sudoku.ApplyValues do
    def run(map, values) do
        Enum.reduce(Map.keys(values), map, fn(key, acc) ->
          Map.put(acc, key, Map.get(values, key))
        end)
    end
end
