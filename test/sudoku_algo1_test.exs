defmodule SudokuAlgo1Test do
  use ExUnit.Case
  import Sudoku.Algo1

  test "times" do
    assert Sudoku.Algo1.times(4,2) == 8
  end

  test "create built in map" do
    assert Sudoku.Algo1.create_built_in_map("003020600000000000000000000000000000000000000000000000000000000000000000000000000")
      == %{
        {2,0} => "3",
        {4,0} => "2",
        {6,0} => "6",
      }
  end

  test "create built in map2" do
    assert Sudoku.Algo1.create_built_in_map("003020600" <> "000000000" <> "000000000" <> "070000000" <> "000000000" <> "000000000" <> "005000000" <> "000000000" <> "000000900")
      == %{
        {2,0} => "3",
        {4,0} => "2",
        {6,0} => "6",
        {1,3} => "7",
        {2,6} => "5",
        {6,8} => "9",
      }
  end

end
