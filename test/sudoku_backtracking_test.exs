defmodule SudokuBacktrackingTest do
  use ExUnit.Case, async: true

  setup do

  # on_exit fn ->
  #   IO.puts "This is invoked once the test is done"
  # end

  # Returns extra metadata to be merged into context
  [a_valid_sudoku:
      "521934768" <>
      "768125349" <>
      "349768152" <>
      "976583214" <>
      "412697583" <>
      "853412697" <>
      "295871436" <>
      "634259871" <>
      "187346925",
  a_valid_sudoku_2:
      "568427193" <>
      "397165824" <>
      "412983567" <>
      "759834612" <>
      "841276359" <>
      "236591748" <>
      "985712436" <>
      "674359281" <>
      "123648975",
    a_not_valid_sudoku:
      "003020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900"
    ]
end

  # @tag :pending
  test "create built in map" do
    assert Sudoku.DataStructureUtils.input_str_to_map("003020600000000000000000000000000000000000000000000000000000000000000000000000000")
      == %{
        {2,0} => [3],
        {4,0} => [2],
        {6,0} => [6],
      }
  end

  # @tag :pending
  test "create built in map2" do
    assert Sudoku.DataStructureUtils.input_str_to_map("003020600" <> "000000000" <> "000000000" <> "070000000" <> "000000000" <> "000000000" <> "005000000" <> "000000000" <> "000000900")
      == %{
        {2,0} => [3],
        {4,0} => [2],
        {6,0} => [6],
        {1,3} => [7],
        {2,6} => [5],
        {6,8} => [9],
      }
  end

  # @tag :pending
  test "add" do

    input = Sudoku.DataStructureUtils.input_str_to_map(
    "300020600" <>
    "000000000" <>
    "500000030" <>
    "070000000" <>
    "000000000" <>
    "000000000" <>
    "005000020" <>
    "900000050" <>
    "000000900")

    moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
    map = Map.merge(Sudoku.Board.init, input)
    assert Sudoku.Backtracking.add([], moving_coords, map) == [{{1,0}, 1}]
  end

  # @tag :pending
  test "add 2" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "320020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
      map = Map.merge(Sudoku.Board.init, input)
      map = Map.put(map, {2,0}, [7,8,9])
      assert Sudoku.Backtracking.add([], moving_coords, map) == [{{2,0}, 7}]
  end

  # @tag :pending
  test "add 3" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
      map = Map.merge(Sudoku.Board.init, input)
      map = Map.put(map, {3,0}, [7,8,9])
      stack = Sudoku.Backtracking.add([], moving_coords, map)
      assert Sudoku.Backtracking.add(stack, moving_coords, map) == [{{5,0}, 1}, {{3,0}, 7}]

  end
  # @tag :pending
  test "increase empty stack" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
      map = Map.merge(Sudoku.Board.init, input)
      assert_raise Sudoku.Backtracking.EmptyStack, fn -> Sudoku.Backtracking.increase([], moving_coords, map) end

  end
  # @tag :pending
  test "increase 1" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
      map = Map.merge(Sudoku.Board.init, input)
      assert Sudoku.Backtracking.increase( [{{3,0}, 1}], moving_coords, map) == [{{3,0}, 2}]

  end
  # @tag :pending
  test "increase 2" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
      map = Map.merge(Sudoku.Board.init, input)
      map = Map.put(map, {3,0}, [7,8,9])
      assert Sudoku.Backtracking.increase( [{{3,0}, 8}], moving_coords, map) == [{{3,0}, 9}]

  end

  # @tag :pending
  test "increase 3" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
      map = Map.merge(Sudoku.Board.init, input)
      map = Map.put(map, {3,0}, [7,8,9])
      assert_raise Sudoku.Backtracking.EndOfElements, fn -> Sudoku.Backtracking.increase( [{{3,0}, 9}], moving_coords, map) end

  end

  # @tag :pending
  test "increase 4" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      map = Map.merge(Sudoku.Board.init, input)

      # map |> Sudoku.Display.pretty

      moving_coords = (Sudoku.Board.generate_rows |> List.flatten) -- Map.keys(input)
      map = Map.put(map, {3,0}, [7,8,9])
      assert Sudoku.Backtracking.increase( [{{3,0}, 8}], moving_coords, map) == [{{3,0}, 9}]

  end


  # @tag :pending
  test "drop" do
    input = Sudoku.DataStructureUtils.input_str_to_map(
      "000020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

    map = Map.merge(Sudoku.Board.init, input)
    map = Map.put(map, {1,0}, [7,8,9])
    # map |> Sudoku.Display.pretty
    Agent.start(fn -> map end, name: MV)
    assert Sudoku.Backtracking.drop([{{2,0}, 1}, {{1,0}, 9}, {{0,0}, 0}], map) == [{{0,0}, 0}]
    Agent.stop(MV)
  end

  # @tag :pending
  test "drop 2" do
    Agent.start(fn -> %{} end, name: MV)
    assert_raise Sudoku.Backtracking.EmptyStack, fn ->  Sudoku.Backtracking.drop([], %{})  end
    Agent.stop(MV)
  end

end
