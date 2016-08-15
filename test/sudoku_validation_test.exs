defmodule SudokuValidationTest do
  use ExUnit.Case, async: true


    # @tag :pending
  test "is_row_valid?" do
    input_str = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_row_valid?(1, map) == true
  end

  # @tag :pending
  test "is_row_valid? false" do
    input_str = "003020600990305001001806400008102900700000008006708200002609500800203009005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_row_valid?(1, map) == false
  end

  # @tag :pending
  test "is_column_valid?" do
    input_str = "003020600" <> "900305001" <> "001806400" <> "008102900" <> "700000008" <> "006708200" <> "002609500" <> "800203009" <> "005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_column_valid?(0, map) == true
  end

  # @tag :pending
  test "is_column_valid? false" do
    input_str = "903020600" <> "900305001" <> "001806400" <> "008102900" <> "700000008" <> "006708200" <> "002609500" <> "800203009" <> "005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_column_valid?(0, map) == false
  end

  # @tag :pending
  test "is_box_valid?" do
    input_str = "003020600" <> "900305001" <> "001806400" <> "008102900" <> "700000008" <> "006708200" <> "002609500" <> "800203009" <> "005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_box_valid?(0,map) == true
  end

  # @tag :pending
  test "is_box_valid? false" do
    input_str = "103020600" <> "900305001" <> "001806400" <> "008102900" <> "700000008" <> "006708200" <> "002609500" <> "800203009" <> "005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_box_valid?(0,map) == false
  end

  # @tag :pending
  test "is_valid?" do
    input_str = "003020600" <> "900305001" <> "001806400" <> "008102900" <> "700000008" <> "006708200" <> "002609500" <> "800203009" <> "005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_valid?(map) == true
  end

  # @tag :pending
  test "any_empty_values?" do
    input_str = "003020600" <> "900305001" <> "001806400" <> "008102900" <> "700000008" <> "006708200" <> "002609500" <> "800203009" <> "005010300"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    map = Map.put(map, {4,4}, [])
    assert Sudoku.Validation.any_empty_values?(map) == true
  end

  # @tag :pending
  test "is_valid 2?" do
    input_str = "483921657967345821251876493548132976729564138136798245372689514814253769695417382"
    input_map = Sudoku.DataStructureUtils.input_str_to_map(input_str)
    map = Sudoku.ApplyValues.run(Sudoku.Board.init, input_map)
    assert Sudoku.Validation.is_valid?(map) == true
  end

end
