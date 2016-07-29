defmodule SudokuAlgo1Test do
  use ExUnit.Case, async: true
  import Sudoku.Algo1

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
  test "times" do
    assert Sudoku.Algo1.times(4,2) == 8
  end

  # @tag :pending
  test "create built in map" do
    assert Sudoku.Algo1.create_built_in_values("003020600000000000000000000000000000000000000000000000000000000000000000000000000")
      == %{
        {2,0} => "3",
        {4,0} => "2",
        {6,0} => "6",
      }
  end

  # @tag :pending
  test "create built in map2" do
    assert Sudoku.Algo1.create_built_in_values("003020600" <> "000000000" <> "000000000" <> "070000000" <> "000000000" <> "000000000" <> "005000000" <> "000000000" <> "000000900")
      == %{
        {2,0} => "3",
        {4,0} => "2",
        {6,0} => "6",
        {1,3} => "7",
        {2,6} => "5",
        {6,8} => "9",
      }
  end

  # @tag :pending
  test "create_cols" do
    assert Sudoku.Algo1.create_cols == [
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
  test "create_cols with size 5" do
    assert Sudoku.Algo1.create_cols(5) == [
      [{0,0},{0,1},{0,2},{0,3},{0,4}],
      [{1,0},{1,1},{1,2},{1,3},{1,4}],
      [{2,0},{2,1},{2,2},{2,3},{2,4}],
      [{3,0},{3,1},{3,2},{3,3},{3,4}],
      [{4,0},{4,1},{4,2},{4,3},{4,4}],
    ]
  end

  # @tag :pending
  test "create_rows" do
    assert Sudoku.Algo1.create_rows == [
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
  test "create_boxes" do
    assert Sudoku.Algo1.create_boxes == [
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
    assert Sudoku.Algo1.get_box_coordinates({5,5}) ==
      [{3,3},{3,4},{3,5},{4,3},{4,4},{4,5},{5,3},{5,4},{5,5}]
  end

  # @tag :pending
  test "get col coordinates" do
    assert Sudoku.Algo1.get_col_coordinates(3) ==
      [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
  end

  # @tag :pending
  test "get row coordinates" do
    assert Sudoku.Algo1.get_row_coordinates(4) ==
      [{0,4},{1,4},{2,4},{3,4},{4,4},{5,4},{6,4},{7,4},{8,4}]
  end

  # @tag :pending
  test "merge uniq 2" do
    assert Sudoku.Algo1.merge_uniq([{{0,0}, "1"}], [{{0,0}, "1"}]) ==
      [{{0,0}, "1"}]
  end

  # @tag :pending
  test "merge uniq" do
    assert Sudoku.Algo1.merge_uniq([{{0,0}, "1"}, {{1,1}, "1"}, {{2,2}, "2"}], [{{0,0}, "1"}, {{2,2}, "2"}]) ==
      [{{0,0}, "1"}, {{1,1}, "1"}, {{2,2}, "2"}]
  end

  # @tag :pending
  test "get row" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "003020600" <>
      "000000000" <>
      "000000000" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000000" <>
      "000000000" <>
      "000000900")
    assert Sudoku.Algo1.get_row(0, [{{0,0}, "1"}], built_in_values) ==
      [{{0,0},"1"},{{2,0},"3"},{{4,0},"2"},{{6,0},"6"}]
  end

  # @tag :pending
  test "get col" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "003020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000090" <>
      "900000000" <>
      "000000900")
    assert Sudoku.Algo1.get_col(7, [{{7,0}, "1"}], built_in_values) ==
      [{{7,0},"1"},{{7,2},"3"},{{7,6},"9"}]
  end

  # @tag :pending
  test "get box" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "003020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.get_box({6,7}, [{{6,6}, "1"}], built_in_values) ==
      [{{6,6}, "1"}, {{6,8},"9"}, {{7,6},"2"},{{7,7},"5"}]
  end

  # @tag :pending
  test "is_row_valid? should be true", context do
    a_not_valid_sudoku = context[:a_not_valid_sudoku]

    built_in_values =
      Sudoku.Algo1.create_built_in_values(a_not_valid_sudoku)
    assert Sudoku.Algo1.is_row_valid?(0, [{{0,0}, "1"}], built_in_values) == true
  end


  # @tag :pending
  test "is_row_valid? should be false" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "001020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.is_row_valid?(0, [{{0,0}, "1"}], built_in_values) == false
  end


  # @tag :pending
  test "is_rows_valid?", context do
  a_valid_sudoku = context[:a_valid_sudoku_2]
    built_in_values =
      Sudoku.Algo1.create_built_in_values(a_valid_sudoku)
    assert Sudoku.Algo1.is_rows_valid?([{{0,0}, "5"}], built_in_values) == true
  end



  # @tag :pending
  test "is_col_valid? should be true" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "001020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.is_col_valid?(0, [{{0,0}, "1"}], built_in_values) == true
  end

  # @tag :pending
  test "is_col_valid? should be false" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "001020600" <>
      "000000000" <>
      "100000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.is_col_valid?(0, [{{0,0}, "1"}], built_in_values) == false
  end

  # @tag :pending
  test "is_cols_valid?", context do
    built_in_values = Sudoku.Algo1.create_built_in_values(context[:a_valid_sudoku_2])
    assert Sudoku.Algo1.is_cols_valid?([{{0,0}, "5"}], built_in_values) == true
  end



  # @tag :pending
  test "is_box_valid?" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "009020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.is_box_valid?({0,0}, [{{0,0}, "1"}], built_in_values) == true
  end

  # @tag :pending
  test "is_box_valid? should be false" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "005020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.is_box_valid?({0,0}, [{{0,0}, "1"}], built_in_values) == false
  end

  # @tag :pending
  test "is_valid? should be false" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "005020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.is_valid?([{{0,0}, "1"}], built_in_values) == false
  end

  # @tag :pending
  test "is_valid?", context do
    built_in_values = Sudoku.Algo1.create_built_in_values(context[:a_valid_sudoku_2])
    assert Sudoku.Algo1.is_valid?([{{0,0}, "5"}], built_in_values) == true
  end

  # @tag :pending
  test "add" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "005020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.add([{{0,0}, "5"}], built_in_values) ==
      [{{0,0}, "5"}, {{1,0}, "0"}]
    assert Sudoku.Algo1.add([{{8,0}, "5"}], built_in_values) ==
      [{{8,0}, "5"}, {{0,1}, "0"}]
    assert_raise Sudoku.Algo1.LastElement, fn -> Sudoku.Algo1.add([{{8,8}, "5"}], built_in_values) end
  end

  # @tag :pending
  test "get next coordinates" do
    assert Sudoku.Algo1.get_next_coordonates({{0,0}, "5"}) == {1,0}
    assert Sudoku.Algo1.get_next_coordonates({{8,0}, "5"}) == {0,1}
    assert Sudoku.Algo1.get_next_coordonates({{8,3}, "5"}) == {0,4}
    assert_raise Sudoku.Algo1.LastElement, fn -> Sudoku.Algo1.get_next_coordonates({{8,8}, "5"}) end
  end

end
