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
        {2,0} => 3,
        {4,0} => 2,
        {6,0} => 6,
      }
  end

  # @tag :pending
  test "create built in map2" do
    assert Sudoku.Algo1.create_built_in_values("003020600" <> "000000000" <> "000000000" <> "070000000" <> "000000000" <> "000000000" <> "005000000" <> "000000000" <> "000000900")
      == %{
        {2,0} => 3,
        {4,0} => 2,
        {6,0} => 6,
        {1,3} => 7,
        {2,6} => 5,
        {6,8} => 9,
      }
  end

  # @tag :pending
  test "generate_board_columns" do
    assert Sudoku.Algo1.generate_board_columns == [
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
  test "generate_board_columns with size 5" do
    assert Sudoku.Algo1.generate_board_columns(5) == [
      [{0,0},{0,1},{0,2},{0,3},{0,4}],
      [{1,0},{1,1},{1,2},{1,3},{1,4}],
      [{2,0},{2,1},{2,2},{2,3},{2,4}],
      [{3,0},{3,1},{3,2},{3,3},{3,4}],
      [{4,0},{4,1},{4,2},{4,3},{4,4}],
    ]
  end

  # @tag :pending
  test "generate_board_rows" do
    assert Sudoku.Algo1.generate_board_rows == [
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
    assert Sudoku.Algo1.generate_board_boxes == [
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
    assert Sudoku.Algo1.get_row(0, [{{0,0}, 1}], built_in_values) ==
      [{{0,0},1},{{2,0},3},{{4,0},2},{{6,0},6}]
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
    assert Sudoku.Algo1.get_col(7, [{{7,0}, 1}], built_in_values) ==
      [{{7,0},1},{{7,2},3},{{7,6},9}]
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
    assert Sudoku.Algo1.get_box({6,7}, [{{6,6}, 1}], built_in_values) ==
      [{{6,6}, 1}, {{6,8},9}, {{7,6},2},{{7,7},5}]
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
    assert Sudoku.Algo1.is_row_valid?(0, [{{0,0}, 1}], built_in_values) == false
  end


  # @tag :pending
  test "is_rows_valid?", context do
  a_valid_sudoku = context[:a_valid_sudoku_2]
    built_in_values =
      Sudoku.Algo1.create_built_in_values(a_valid_sudoku)
    assert Sudoku.Algo1.is_rows_valid?([{{0,0}, 5}], built_in_values) == true
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
    assert Sudoku.Algo1.is_col_valid?(0, [{{0,0}, 1}], built_in_values) == true
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
    assert Sudoku.Algo1.is_col_valid?(0, [{{0,0}, 1}], built_in_values) == false
  end

  # @tag :pending
  test "is_cols_valid?", context do
    built_in_values = Sudoku.Algo1.create_built_in_values(context[:a_valid_sudoku_2])
    assert Sudoku.Algo1.is_cols_valid?([{{0,0}, 5}], built_in_values) == true
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
    assert Sudoku.Algo1.is_box_valid?({0,0}, [{{0,0}, 1}], built_in_values) == true
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
    assert Sudoku.Algo1.is_box_valid?({0,0}, [{{0,0}, 1}], built_in_values) == false
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
    assert Sudoku.Algo1.is_valid?([{{0,0}, 1}], built_in_values) == false
  end

  # @tag :pending
  test "is_valid?", context do
    built_in_values = Sudoku.Algo1.create_built_in_values(context[:a_valid_sudoku_2])
    assert Sudoku.Algo1.is_valid?([{{0,0}, 5}], built_in_values) == true
  end

  # @tag :pending
  test "add" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "300020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.add([], built_in_values) ==
      [{{1,0}, 0}, {{0,0}, 3}]
  end

  # @tag :pending
  test "add 2" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "320020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.add([], built_in_values) ==
      [{{2,0}, 0}, {{1,0}, 2}, {{0,0}, 3}]
  end
  # @tag :pending
  test "add 3" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.add([], built_in_values) ==
      [{{3,0}, 0}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}]
    assert_raise Sudoku.Algo1.LastElement, fn -> Sudoku.Algo1.add([{{8,8}, 3}], built_in_values) end
  end

  # @tag :pending
  test "add 4" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "325121611" <>
      "111111111" <>
      "511111131" <>
      "171111111" <>
      "111111111" <>
      "111111111" <>
      "115111121" <>
      "911111151" <>
      "111111910")

      built_in_values = Map.put(built_in_values, {8,8}, 4)

    assert Sudoku.Algo1.add([], built_in_values) ==
      [{{8, 8}, 4}, {{7, 8}, 1}, {{6, 8}, 9}, {{5, 8}, 1}, {{4, 8}, 1}, {{3, 8}, 1},
       {{2, 8}, 1}, {{1, 8}, 1}, {{0, 8}, 1}, {{8, 7}, 1}, {{7, 7}, 5}, {{6, 7}, 1},
       {{5, 7}, 1}, {{4, 7}, 1}, {{3, 7}, 1}, {{2, 7}, 1}, {{1, 7}, 1}, {{0, 7}, 9},
       {{8, 6}, 1}, {{7, 6}, 2}, {{6, 6}, 1}, {{5, 6}, 1}, {{4, 6}, 1}, {{3, 6}, 1},
       {{2, 6}, 5}, {{1, 6}, 1}, {{0, 6}, 1}, {{8, 5}, 1}, {{7, 5}, 1}, {{6, 5}, 1},
       {{5, 5}, 1}, {{4, 5}, 1}, {{3, 5}, 1}, {{2, 5}, 1}, {{1, 5}, 1}, {{0, 5}, 1},
       {{8, 4}, 1}, {{7, 4}, 1}, {{6, 4}, 1}, {{5, 4}, 1}, {{4, 4}, 1}, {{3, 4}, 1},
       {{2, 4}, 1}, {{1, 4}, 1}, {{0, 4}, 1}, {{8, 3}, 1}, {{7, 3}, 1}, {{6, 3}, 1},
       {{5, 3}, 1}, {{4, 3}, 1}, {{3, 3}, 1}, {{2, 3}, 1}, {{1, 3}, 7}, {{0, 3}, 1},
       {{8, 2}, 1}, {{7, 2}, 3}, {{6, 2}, 1}, {{5, 2}, 1}, {{4, 2}, 1}, {{3, 2}, 1},
       {{2, 2}, 1}, {{1, 2}, 1}, {{0, 2}, 5}, {{8, 1}, 1}, {{7, 1}, 1}, {{6, 1}, 1},
       {{5, 1}, 1}, {{4, 1}, 1}, {{3, 1}, 1}, {{2, 1}, 1}, {{1, 1}, 1}, {{0, 1}, 1},
       {{8, 0}, 1}, {{7, 0}, 1}, {{6, 0}, 6}, {{5, 0}, 1}, {{4, 0}, 2}, {{3, 0}, 1},
       {{2, 0}, 5}, {{1, 0}, 2}, {{0, 0}, 3}]
  end

  # @tag :pending
  test "get next coordinates" do
    assert Sudoku.Algo1.get_next_coordonates({{0,0}, 5}) == {1,0}
    assert Sudoku.Algo1.get_next_coordonates({{8,0}, 5}) == {0,1}
    assert Sudoku.Algo1.get_next_coordonates({{8,3}, 5}) == {0,4}
    assert_raise Sudoku.Algo1.LastElement, fn -> Sudoku.Algo1.get_next_coordonates({{8,8}, 5}) end
  end

  # @tag :pending
  test "increase" do
    assert Sudoku.Algo1.increase([{{3,0}, 0}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}])
      == [{{3,0}, 1}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}]
    assert Sudoku.Algo1.increase([{{3,0}, 9}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}])
      == :drop
  end

  # @tag :pending
  test "drop" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "325020600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.drop([{{3,0}, 0}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}], built_in_values)
      == []
  end

  # @tag :pending
  test "drop 2" do
    built_in_values =
      Sudoku.Algo1.create_built_in_values(
      "325000600" <>
      "000000000" <>
      "500000030" <>
      "070000000" <>
      "000000000" <>
      "000000000" <>
      "005000020" <>
      "900000050" <>
      "000000900")
    assert Sudoku.Algo1.drop([{{4,0}, 9}, {{3,0}, 0}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}], built_in_values)
      == [{{3,0}, 0}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}]
    assert Sudoku.Algo1.drop([{{5,0}, 9}, {{4,0}, 9}, {{3,0}, 0}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}], built_in_values)
      == [{{3,0}, 0}, {{2,0}, 5}, {{1,0}, 2}, {{0,0}, 3}]
  end

end
