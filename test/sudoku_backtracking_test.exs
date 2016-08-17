defmodule SudokuBacktrackingTest do
  use ExUnit.Case, async: true

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
  test "iterate empty stack" do
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
      assert_raise Sudoku.Backtracking.EmptyStack, fn -> Sudoku.Backtracking.iterate([], moving_coords, map) end

  end
  # @tag :pending
  test "iterate 1" do
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
      assert Sudoku.Backtracking.iterate( [{{3,0}, 1}], moving_coords, map) == [{{3,0}, 2}]

  end
  # @tag :pending
  test "iterate 2" do
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
      assert Sudoku.Backtracking.iterate( [{{3,0}, 8}], moving_coords, map) == [{{3,0}, 9}]

  end

  # @tag :pending
  test "iterate 3" do
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
      assert_raise Sudoku.Backtracking.NoMorePossibilitiesForThisElement, fn -> Sudoku.Backtracking.iterate( [{{3,0}, 9}], moving_coords, map) end

  end

  # @tag :pending
  test "iterate 4" do
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
      assert Sudoku.Backtracking.iterate( [{{3,0}, 8}], moving_coords, map) == [{{3,0}, 9}]

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
