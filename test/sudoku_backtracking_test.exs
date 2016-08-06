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
    assert Sudoku.Algo2.input_to_map("003020600000000000000000000000000000000000000000000000000000000000000000000000000")
      == %{
        {2,0} => [3],
        {4,0} => [2],
        {6,0} => [6],
      }
  end

  # @tag :pending
  test "create built in map2" do
    assert Sudoku.Algo2.input_to_map("003020600" <> "000000000" <> "000000000" <> "070000000" <> "000000000" <> "000000000" <> "005000000" <> "000000000" <> "000000900")
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
  test "Sudoku.Board.generate_board_columns" do
    assert Sudoku.Board.generate_board_columns == [
      [{0,0},{0,1},{0,2},{0,3},{0,4},{0,5},{0,6},{0,7},{0,8},],
      [{1,0},{1,1},{1,2},{1,3},{1,4},{1,5},{1,6},{1,7},{1,8},],
      [{2,0},{2,1},{2,2},{2,3},{2,4},{2,5},{2,6},{2,7},{2,8},],
      [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8},],
      [{4,0},{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},{4,7},{4,8},],
      [{5,0},{5,1},{5,2},{5,3},{5,4},{5,5},{5,6},{5,7},{5,8},],
      [{6,0},{6,1},{6,2},{6,3},{6,4},{6,5},{6,6},{6,7},{6,8},],
      [{7,0},{7,1},{7,2},{7,3},{7,4},{7,5},{7,6},{7,7},{7,8},],
      [{8,0},{8,1},{8,2},{8,3},{8,4},{8,5},{8,6},{8,7},{8,8},],
    ]
  end

  # @tag :pending
  test "Sudoku.Board.generate_board_columns with size 5" do
    assert Sudoku.Board.generate_board_columns(5) == [
      [{0,0},{0,1},{0,2},{0,3},{0,4}],
      [{1,0},{1,1},{1,2},{1,3},{1,4}],
      [{2,0},{2,1},{2,2},{2,3},{2,4}],
      [{3,0},{3,1},{3,2},{3,3},{3,4}],
      [{4,0},{4,1},{4,2},{4,3},{4,4}],
    ]
  end

  # @tag :pending
  test "generate_board_rows" do
    assert Sudoku.Board.generate_board_rows == [
      [{0,0},{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0},{8,0},],
      [{0,1},{1,1},{2,1},{3,1},{4,1},{5,1},{6,1},{7,1},{8,1},],
      [{0,2},{1,2},{2,2},{3,2},{4,2},{5,2},{6,2},{7,2},{8,2},],
      [{0,3},{1,3},{2,3},{3,3},{4,3},{5,3},{6,3},{7,3},{8,3},],
      [{0,4},{1,4},{2,4},{3,4},{4,4},{5,4},{6,4},{7,4},{8,4},],
      [{0,5},{1,5},{2,5},{3,5},{4,5},{5,5},{6,5},{7,5},{8,5},],
      [{0,6},{1,6},{2,6},{3,6},{4,6},{5,6},{6,6},{7,6},{8,6},],
      [{0,7},{1,7},{2,7},{3,7},{4,7},{5,7},{6,7},{7,7},{8,7},],
      [{0,8},{1,8},{2,8},{3,8},{4,8},{5,8},{6,8},{7,8},{8,8},],
    ]
  end

  # @tag :pending
  test "generate_board_boxes" do
    assert Sudoku.Board.generate_board_boxes == [
      [{0,0},{0,1},{0,2},{1,0},{1,1},{1,2},{2,0},{2,1},{2,2}],
      [{3,0},{3,1},{3,2},{4,0},{4,1},{4,2},{5,0},{5,1},{5,2}],
      [{6,0},{6,1},{6,2},{7,0},{7,1},{7,2},{8,0},{8,1},{8,2}],
      [{0,3},{0,4},{0,5},{1,3},{1,4},{1,5},{2,3},{2,4},{2,5}],
      [{3,3},{3,4},{3,5},{4,3},{4,4},{4,5},{5,3},{5,4},{5,5}],
      [{6,3},{6,4},{6,5},{7,3},{7,4},{7,5},{8,3},{8,4},{8,5}],
      [{0,6},{0,7},{0,8},{1,6},{1,7},{1,8},{2,6},{2,7},{2,8}],
      [{3,6},{3,7},{3,8},{4,6},{4,7},{4,8},{5,6},{5,7},{5,8}],
      [{6,6},{6,7},{6,8},{7,6},{7,7},{7,8},{8,6},{8,7},{8,8}],
    ]
  end

  # @tag :pending
  test "get box coordinates" do
    assert Sudoku.Board.get_box_coordinates({5,5}) ==
      [{3,3},{3,4},{3,5},{4,3},{4,4},{4,5},{5,3},{5,4},{5,5}]
  end

  # @tag :pending
  test "get col coordinates" do
    assert Sudoku.Board.get_col_coordinates(3) ==
      [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  end

  # @tag :pending
  test "get row coordinates" do
    assert Sudoku.Board.get_row_coordinates(4) ==
      [{0,4},{1,4},{2,4},{3,4},{4,4},{5,4},{6,4},{7,4},{8,4}]
  end

  # @tag :pending
  test "add" do

    input = Sudoku.Algo2.input_to_map(
    "300020600" <>
    "000000000" <>
    "500000030" <>
    "070000000" <>
    "000000000" <>
    "000000000" <>
    "005000020" <>
    "900000050" <>
    "000000900")

    moving_coords = Sudoku.Algo2.order -- Map.keys(input)
    map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
    assert Sudoku.Backtracking.add([], moving_coords, map) == [{{1,0}, 1}]
  end

  # @tag :pending
  test "add 2" do
    input = Sudoku.Algo2.input_to_map(
      "320020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = Sudoku.Algo2.order -- Map.keys(input)
      map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
      map = Map.put(map, {2,0}, [7,8,9])
      assert Sudoku.Backtracking.add([], moving_coords, map) == [{{2,0}, 7}]
  end

  # @tag :pending
  test "add 3" do
    input = Sudoku.Algo2.input_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = Sudoku.Algo2.order -- Map.keys(input)
      map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
      map = Map.put(map, {3,0}, [7,8,9])
      stack = Sudoku.Backtracking.add([], moving_coords, map)
      assert Sudoku.Backtracking.add(stack, moving_coords, map) == [{{5,0}, 1}, {{3,0}, 7}]

  end
  # @tag :pending
  test "increase empty stack" do
    input = Sudoku.Algo2.input_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = Sudoku.Algo2.order -- Map.keys(input)
      map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
      assert_raise Sudoku.Backtracking.EmptyStack, fn -> Sudoku.Backtracking.increase([], moving_coords, map) end

  end
  # @tag :pending
  test "increase 1" do
    input = Sudoku.Algo2.input_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = Sudoku.Algo2.order -- Map.keys(input)
      map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
      assert Sudoku.Backtracking.increase( [{{3,0}, 1}], moving_coords, map) == [{{3,0}, 2}]

  end
  # @tag :pending
  test "increase 2" do
    input = Sudoku.Algo2.input_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = Sudoku.Algo2.order -- Map.keys(input)
      map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
      map = Map.put(map, {3,0}, [7,8,9])
      assert Sudoku.Backtracking.increase( [{{3,0}, 8}], moving_coords, map) == [{{3,0}, 9}]

  end

  # @tag :pending
  test "increase 3" do
    input = Sudoku.Algo2.input_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      moving_coords = Sudoku.Algo2.order -- Map.keys(input)
      map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
      map = Map.put(map, {3,0}, [7,8,9])
      assert_raise Sudoku.Backtracking.EndOfElements, fn -> Sudoku.Backtracking.increase( [{{3,0}, 9}], moving_coords, map) end

  end

  # @tag :pending
  test "increase 4" do
    input = Sudoku.Algo2.input_to_map(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

      map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)

      # map |> Sudoku.Display.pretty

      moving_coords = Sudoku.Algo2.order -- Map.keys(input)
      map = Map.put(map, {3,0}, [7,8,9])
      assert Sudoku.Backtracking.increase( [{{3,0}, 8}], moving_coords, map) == [{{3,0}, 9}]

  end


  # @tag :pending
  test "drop" do
    input = Sudoku.Algo2.input_to_map(
      "000020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")

    map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map, input)
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
