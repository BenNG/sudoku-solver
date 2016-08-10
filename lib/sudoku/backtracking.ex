defmodule Sudoku.Backtracking do
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
    Using all the possibilities
    End now
  """

  def run(map, output \\ :map) do
    # IO.inspect "starting 1 ... with"
    # map |> Sudoku.Display.pretty
    Agent.start(fn -> map end, name: MV)

    moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(Sudoku.DataStructureUtils.filter_fixed_values(map))

    # IO.inspect "moving_coords: #{inspect moving_coords}"

    stack = add([], moving_coords, map)
    map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
    # map |> Sudoku.Display.pretty
    do_run(stack, moving_coords, map, output, 0)
  end

  def do_run(stack, moving_coords, map, output, count) do

    # if count === 100000, do: raise "count === #{count}"

    if Sudoku.Validation.is_valid?(map) === false do
      if Sudoku.Validation.is_complete?(map) do
        # IO.inspect "c'est bon !"
        Agent.stop(MV)
        case output do
          :map -> map
          :raw -> Sudoku.Algo2.map_to_raw_data(map)
        end
      else
        # IO.inspect "valid: add"
        stack = add(stack, moving_coords, map)
        # IO.inspect "stack is now: #{inspect stack}"
        map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
        # map |> Sudoku.Display.pretty

        do_run(stack, moving_coords, map, output, count + 1)
      end
    else
      if is_last_value_to_test?(stack, Agent.get(MV, &(&1))) do
        # IO.inspect "not valid: drop"
        stack = drop(stack, map)
        # IO.inspect "stack is now: #{inspect stack}"
        stack = increase(stack, moving_coords, Agent.get(MV, &(&1)))
        map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
        do_run(stack, moving_coords, map, output, count + 1)
      else
        # IO.inspect "not valid: increase"
        stack = increase(stack, moving_coords, Agent.get(MV, &(&1)))
        map = apply_stack_to_map(stack, Agent.get(MV, &(&1)))
        do_run(stack, moving_coords, map, output, count + 1)
      end
    end
  end

  def apply_stack_to_map(stack, map) do
    Sudoku.ApplyValues.run(map, Sudoku.DataStructureUtils.stack_to_map(stack))
  end

  def is_last_value_to_test?([], _), do: raise Sudoku.Backtracking.EmptyStack
  def is_last_value_to_test?([{coor,v}|_], map) do
    mv = Map.get(map, coor)
    index = Enum.find_index(mv, fn(x) -> x == v end)
    bool = index === length(mv) - 1
    # IO.inspect "last value for : #{inspect {coor, v}} --> #{bool}"
    if bool, do: true, else: false
  end

  def add([], [coor|_] = _, map) do
    values = Map.get(map, coor)
    v = Enum.fetch!(values, 0)
    # IO.inspect "adding: #{inspect {coor, v}}"
    [{coor, v}]
  end

  def add([h|_] = stack, moving_coords, map) do
    index = Enum.find_index(moving_coords, fn(x) -> x == elem(h,0) end)
    coor = Enum.fetch!(moving_coords, index + 1)
    values = Map.get(map, coor)
    v = Enum.fetch!(values, 0)
    # IO.inspect "adding: #{inspect {coor, v}}"
    [{coor, v}|stack]
  end

  def increase([], _, _), do: raise Sudoku.Backtracking.EmptyStack
  def increase([{coor, v}|t], _, map) do
    # IO.inspect "map #{inspect map}"
    # IO.inspect "increase from #{inspect {coor, v} }"
    values = Map.get(map, coor)
    index = Enum.find_index(values, fn(x) -> x == v end)
    if index === length(values) - 1 do
      raise Sudoku.Backtracking.EndOfElements
    else
      new_v = Enum.fetch!(values, index + 1)
      # IO.inspect "to #{inspect {coor, new_v} }"
      [{coor, new_v}|t]
    end
  end

  def drop([], _), do: raise Sudoku.Backtracking.EmptyStack
  def drop([_h|t] = stack, map) do
    # IO.inspect "droping: #{inspect _h}"
    # IO.inspect "stack: #{inspect stack}"
    if is_last_value_to_test?(t, Agent.get(MV, &(&1))) do
      drop(t, map)
    else
      t
    end
  end

  defmodule EndOfElements do
    defexception []
    def message(_), do: "No more values, you probably have to drop the element"
  end

  defmodule EmptyStack do
    defexception []
    def message(_), do: "Could not operate on empty stack"
  end

  defmodule BadInputLength do
    defexception []
    def message(_), do: "Please provide an input with 81 codepoints"
  end

end
