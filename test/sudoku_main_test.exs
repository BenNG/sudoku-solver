defmodule SudokuMainTest do
  use ExUnit.Case, async: true

  setup do
    [
      input_str_1: "003020600900305001001806400008102900700000008006708200002609500800203009005010300",
      input_str_1_result: "483921657967345821251876493548132976729564138136798245372689514814253769695417382",
      input_str_2: "200080300060070084030500209000105408000000000402706000301007040720040060004010003",
      input_str_2_result: "245981376169273584837564219976125438513498627482736951391657842728349165654812793",
      input_str_3: "100920000524010000000000070050008102000000000402700090060000000000030945000071006",
      input_str_3_result: "176923584524817639893654271957348162638192457412765398265489713781236945349571826",
      input_str_4: "850002400720000009004000000000107002305000900040000000000080070017000000000036040",
      input_str_4_result: "859612437723854169164379528986147352375268914241593786432981675617425893598736241",
      input_str_5: "005300000800000020070010500400005300010070006003200080060500009004000030000009700",
      input_str_5_result: "145327698839654127672918543496185372218473956753296481367542819984761235521839764",
    ]
  end

  # @tag :pending
  test "length values == 1 in map" do
    assert Sudoku.DataStructureUtils.filter_fixed_values(%{
      "aze" => [1,2,3],
      "qsd" => [1,2],
      "wxc" => [1]
      }) === %{
        "wxc" => [1]
      }
  end

  # @tag :pending
  test "apply values" do
    raw = "003020600000000000000000000000000000000000000000000000000000000000000000000000000"
    raw_map = Sudoku.DataStructureUtils.input_str_to_map(raw)
    values = Sudoku.Board.init
    assert Sudoku.ApplyValues.run(values, raw_map) == %{
      {0,0} => [1,4,5,7,8,9],
      {1,0} => [1,4,5,7,8,9],
      {2,0} => [3],
      {3,0} => [1,4,5,7,8,9],
      {4,0} => [2],
      {5,0} => [1,4,5,7,8,9],
      {6,0} => [6],
      {7,0} => [1,4,5,7,8,9],
      {8,0} => [1,4,5,7,8,9],
      {0,1} => [1,2,4,5,6,7,8,9],
      {1,1} => [1,2,4,5,6,7,8,9],
      {2,1} => [1,2,4,5,6,7,8,9],
      {3,1} => [1,3,4,5,6,7,8,9],
      {4,1} => [1,3,4,5,6,7,8,9],
      {5,1} => [1,3,4,5,6,7,8,9],
      {6,1} => [1,2,3,4,5,7,8,9],
      {7,1} => [1,2,3,4,5,7,8,9],
      {8,1} => [1,2,3,4,5,7,8,9],
      {0,2} => [1,2,4,5,6,7,8,9],
      {1,2} => [1,2,4,5,6,7,8,9],
      {2,2} => [1,2,4,5,6,7,8,9],
      {3,2} => [1,3,4,5,6,7,8,9],
      {4,2} => [1,3,4,5,6,7,8,9],
      {5,2} => [1,3,4,5,6,7,8,9],
      {6,2} => [1,2,3,4,5,7,8,9],
      {7,2} => [1,2,3,4,5,7,8,9],
      {8,2} => [1,2,3,4,5,7,8,9],
      {0,3} => [1,2,3,4,5,6,7,8,9],
      {1,3} => [1,2,3,4,5,6,7,8,9],
      {2,3} => [1,2,4,5,6,7,8,9],
      {3,3} => [1,2,3,4,5,6,7,8,9],
      {4,3} => [1,3,4,5,6,7,8,9],
      {5,3} => [1,2,3,4,5,6,7,8,9],
      {6,3} => [1,2,3,4,5,7,8,9],
      {7,3} => [1,2,3,4,5,6,7,8,9],
      {8,3} => [1,2,3,4,5,6,7,8,9],
      {0,4} => [1,2,3,4,5,6,7,8,9],
      {1,4} => [1,2,3,4,5,6,7,8,9],
      {2,4} => [1,2,4,5,6,7,8,9],
      {3,4} => [1,2,3,4,5,6,7,8,9],
      {4,4} => [1,3,4,5,6,7,8,9],
      {5,4} => [1,2,3,4,5,6,7,8,9],
      {6,4} => [1,2,3,4,5,7,8,9],
      {7,4} => [1,2,3,4,5,6,7,8,9],
      {8,4} => [1,2,3,4,5,6,7,8,9],
      {0,5} => [1,2,3,4,5,6,7,8,9],
      {1,5} => [1,2,3,4,5,6,7,8,9],
      {2,5} => [1,2,4,5,6,7,8,9],
      {3,5} => [1,2,3,4,5,6,7,8,9],
      {4,5} => [1,3,4,5,6,7,8,9],
      {5,5} => [1,2,3,4,5,6,7,8,9],
      {6,5} => [1,2,3,4,5,7,8,9],
      {7,5} => [1,2,3,4,5,6,7,8,9],
      {8,5} => [1,2,3,4,5,6,7,8,9],
      {0,6} => [1,2,3,4,5,6,7,8,9],
      {1,6} => [1,2,3,4,5,6,7,8,9],
      {2,6} => [1,2,4,5,6,7,8,9],
      {3,6} => [1,2,3,4,5,6,7,8,9],
      {4,6} => [1,3,4,5,6,7,8,9],
      {5,6} => [1,2,3,4,5,6,7,8,9],
      {6,6} => [1,2,3,4,5,7,8,9],
      {7,6} => [1,2,3,4,5,6,7,8,9],
      {8,6} => [1,2,3,4,5,6,7,8,9],
      {0,7} => [1,2,3,4,5,6,7,8,9],
      {1,7} => [1,2,3,4,5,6,7,8,9],
      {2,7} => [1,2,4,5,6,7,8,9],
      {3,7} => [1,2,3,4,5,6,7,8,9],
      {4,7} => [1,3,4,5,6,7,8,9],
      {5,7} => [1,2,3,4,5,6,7,8,9],
      {6,7} => [1,2,3,4,5,7,8,9],
      {7,7} => [1,2,3,4,5,6,7,8,9],
      {8,7} => [1,2,3,4,5,6,7,8,9],
      {0,8} => [1,2,3,4,5,6,7,8,9],
      {1,8} => [1,2,3,4,5,6,7,8,9],
      {2,8} => [1,2,4,5,6,7,8,9],
      {3,8} => [1,2,3,4,5,6,7,8,9],
      {4,8} => [1,3,4,5,6,7,8,9],
      {5,8} => [1,2,3,4,5,6,7,8,9],
      {6,8} => [1,2,3,4,5,7,8,9],
      {7,8} => [1,2,3,4,5,6,7,8,9],
      {8,8} => [1,2,3,4,5,6,7,8,9],
    }
  end

  # @tag :pending
  test "get values by length" do
    blocked_map =
      %{
          {3, 3} => [3],
          {2, 2} => [3],
          {6, 4} => [3],
          {2, 0} => [3],
          {8, 6} => [3],
          {8, 7} => [3],
        }

        mm = blocked_map
        |> Sudoku.DataStructureUtils.length_to_values

        assert mm == %{
          1 => [{{8, 7}, [3]},{{8, 6}, [3]},{{6, 4}, [3]},{{3, 3}, [3]},{{2, 2}, [3]},{{2, 0}, [3]}]
        }

  end

  # @tag :pending
  test "is_valid?" do
    assert %{"ze" => [1]} |> Sudoku.Validation.is_valid?  == true
  end

  # @tag :pending
  test "is_complete?" do
    assert %{"ze" => [1]} |> Sudoku.Validation.is_complete?  == true
  end

  # @tag :pending
  test "filter n length of values" do
    map = %{
              {3, 3} => [3, 4, 6],
              {2, 2} => [3, 6, 8, 9],
              {6, 4} => [3, 4, 5, 6, 7, 8],
              {2, 0} => [3, 6, 7, 8],
              {8, 6} => [3, 7, 8],
              {8, 7} => [3, 7],
              {8, 1} => [3, 7],
            }
    assert map |> Sudoku.DataStructureUtils.filter_length_of_values(2)  == %{
              {8, 7} => [3, 7],
              {8, 1} => [3, 7],
            }
  end

  # @tag :pending
  test "map to stack to map" do

    map = %{
              {7, 6} => [1],
              {7, 8} => [2],
              {4, 0} => [2],
              {2, 1} => [4],
              {0, 0} => [1],
              {6, 3} => [1],
              {5, 7} => [6],
              {2, 7} => [1],
              {5, 1} => '\a',
              {8, 7} => [5],
              {5, 6} => '\t',
              {6, 2} => [2],
              {8, 2} => [1],
              {1, 3} => [5],
              {1, 8} => [4],
              {5, 4} => [2],
              {3, 5} => '\a',
              {7, 2} => '\a',
              {7, 5} => '\t',
              {7, 7} => [4],
              {3, 4} => [1],
              {4, 7} => [3],
              {1, 5} => [1],
              {5, 8} => [1],
              {3, 0} => '\t',
              {4, 1} => [1],
              {6, 7} => '\t',
              {1, 6} => [6],
              {8, 8} => [6],
              {8, 1} => '\t',
              {5, 3} => '\b',
              {1, 1} => [2],
              {2, 5} => [2],
              {0, 5} => [4],
              {8, 3} => [2],
              {4, 8} => '\a',
              {0, 1} => [5]
            }

    new_map = map
    |> Sudoku.DataStructureUtils.map_to_stack
    |> Sudoku.DataStructureUtils.stack_to_map
    assert map == new_map
  end

  # @tag :pending
  test "sudoku input_str_1", context do
    input_str_1 = context[:input_str_1]
    input_str_1_result = context[:input_str_1_result]
    {:ok , result} = Sudoku.Main.run(input_str_1)
    assert result |> Sudoku.DataStructureUtils.map_to_input_str == input_str_1_result
  end

  # @tag :pending
  test "sudoku input_str_2", context do
    input_str_2 = context[:input_str_2]
    input_str_2_result = context[:input_str_2_result]
    {:ok , result} = Sudoku.Main.run(input_str_2)
    assert result |> Sudoku.DataStructureUtils.map_to_input_str == input_str_2_result
  end

  # @tag :pending
  # |> Sudoku.Display.pretty
  test "sudoku input_str_3", context do
    input_str_3 = context[:input_str_3]
    input_str_3_result = context[:input_str_3_result]
    {:ok , result} = Sudoku.Main.run(input_str_3)
    assert result |> Sudoku.DataStructureUtils.map_to_input_str == input_str_3_result
  end
  # @tag :pending
  # |> Sudoku.Display.pretty
  test "sudoku input_str_4", context do
    input_str_4 = context[:input_str_4]
    input_str_4_result = context[:input_str_4_result]
    {:ok , result} = Sudoku.Main.run(input_str_4)
    assert result |> Sudoku.DataStructureUtils.map_to_input_str == input_str_4_result
  end
  # @tag :pending
  # |> Sudoku.Display.pretty
  test "sudoku input_str_5", context do
    input_str_5 = context[:input_str_5]
    input_str_5_result = context[:input_str_5_result]
    {:ok , result} = Sudoku.Main.run(input_str_5)
    assert result |> Sudoku.DataStructureUtils.map_to_input_str == input_str_5_result
  end
  # @tag :pending
  # |> Sudoku.Display.pretty
  test "resolve --- euler 96 ---" do
    assert Sudoku.File.resolve_euler_96 == 24702
  end

end
