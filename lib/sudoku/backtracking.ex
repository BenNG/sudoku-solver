defmodule Sudoku.Backtracking do
  @moduledoc """
    Provide set of functions to solve sudoku puzzles
    Using all the possibilities
    End now
  """

  def run(map) do
    # IO.inspect "starting 1 ... with"
    # map |> Sudoku.Display.pretty
    Agent.start(fn -> map end, name: MV)

    moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(Sudoku.DataStructureUtils.filter_fixed_values(map))

    # IO.inspect "moving_coords: #{inspect moving_coords}"

    stack = add([], moving_coords, map)
    map = update_map(stack, Agent.get(MV, &(&1)))
    # map |> Sudoku.Display.pretty
    do_run(stack, moving_coords, map)
  end

  def do_run(stack, moving_coords, map) do

    if Sudoku.Validation.is_valid?(map) do
      if Sudoku.Validation.is_complete?(map) do
        # IO.inspect "c'est bon !"
        Agent.stop(MV)
        map
      else
        # IO.inspect "valid: add"
        stack = add(stack, moving_coords, map)
        # IO.inspect "stack is now: #{inspect stack}"
        map = update_map(stack, Agent.get(MV, &(&1)))
        # map |> Sudoku.Display.pretty

        do_run(stack, moving_coords, map)
      end
    else
      if is_last_possibility?(stack, Agent.get(MV, &(&1))) do
        # IO.inspect "not valid: drop"
        stack = drop(stack, map)
        # IO.inspect "stack is now: #{inspect stack}"
        stack = iterate(stack, moving_coords, Agent.get(MV, &(&1)))
        map = update_map(stack, Agent.get(MV, &(&1)))
        do_run(stack, moving_coords, map)
      else
        # IO.inspect "not valid: iterate"
        stack = iterate(stack, moving_coords, Agent.get(MV, &(&1)))
        map = update_map(stack, Agent.get(MV, &(&1)))
        do_run(stack, moving_coords, map)
      end
    end
  end

  def update_map(stack, map) do
    Sudoku.ApplyValues.run(map, Sudoku.DataStructureUtils.stack_to_map(stack))
  end

  def is_last_possibility?([], _), do: raise Sudoku.Backtracking.EmptyStack
  def is_last_possibility?([{coor,v}|_], map) do
    possibilities = Map.get(map, coor)
    index = Enum.find_index(possibilities, fn(x) -> x == v end)
    bool = index === length(possibilities) - 1
    # IO.inspect "last value for : #{inspect {coor, v}} --> #{bool}"
    bool
  end
  @doc """
  As the stack is empty, we add the fisrt moving element with his first value
  """
  def add([], [coor|_], map) do
    values = Map.get(map, coor)
    v = Enum.fetch!(values, 0)
    # IO.inspect "adding: #{inspect {coor, v}}"
    [{coor, v}]
  end

  def add([{h_coor, _}|_] = stack, moving_coords, map) do
    index = Enum.find_index(moving_coords, &(&1 == h_coor))
    coor = Enum.fetch!(moving_coords, index + 1)
    values = Map.get(map, coor)
    v = Enum.fetch!(values, 0)
    # IO.inspect "adding: #{inspect {coor, v}}"
    [{coor, v}|stack]
  end

  def iterate([], _, _), do: raise Sudoku.Backtracking.EmptyStack
  def iterate([{coor, v}|t], _, map) do
    # IO.inspect "map #{inspect map}"
    # IO.inspect "iterate from #{inspect {coor, v} }"
    values = Map.get(map, coor)
    index = Enum.find_index(values, fn(x) -> x == v end)
    if index === length(values) - 1 do
      raise Sudoku.Backtracking.NoMorePossibilitiesForThisElement
    else
      new_v = Enum.fetch!(values, index + 1)
      # IO.inspect "to #{inspect {coor, new_v} }"
      [{coor, new_v}|t]
    end
  end

  def drop([], _), do: raise Sudoku.Backtracking.EmptyStack
  @doc """
    The tail is empty which is going raise error in iteration
    So in this situation we keep the last element
  """
  def drop([h|[]] = stack, map), do: stack
  def drop([_h|t] = stack, map) do
    if is_last_possibility?(t, Agent.get(MV, &(&1))) do
      # we drop more than one element
      drop(t, map)
    else
      t
    end
  end
  def drop([_h|t] = stack, map) do
    # IO.inspect "droping: #{inspect _h}"
    # IO.inspect "stack: #{inspect stack}"
    if is_last_possibility?(t, Agent.get(MV, &(&1))) do
      drop(t, map)
    else
      t
    end
  end

  defmodule NoMorePossibilitiesForThisElement do
    defexception []
    def message(_), do: "No more values, you probably have to drop the element"
  end

  defmodule EmptyStack do
    defexception []
    def message(_), do: "Could not operate on empty stack"
  end

end
