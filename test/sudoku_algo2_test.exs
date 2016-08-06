defmodule SudokuAlgo2Test do
  use ExUnit.Case, async: true

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
  test "new values found" do

    new_map = %{
      {0,0} => [1],
      {1,0} => [1,2],
      {2,0} => [1,2,3,4,5,6,7,8,9],
      {3,0} => [1,2,3,4,5,6,7,8,9],
      {4,0} => [1,2,3],
      {5,0} => [1,2,3,5,6,7,8,9],
      {6,0} => [1,2,3,4,5,6,7,8,9],
      {7,0} => [1,2,3,4,5,6,7,8,9],
      {8,0} => [8],
    }

    old_map = %{
      {0,0} => [1],
      {1,0} => [1,2],
      {2,0} => [1,2,3,4,5,6,7,8,9],
      {3,0} => [1,2,3,4,5,6,7,8,9],
      {4,0} => [1,2,3],
      {5,0} => [1,2,3,5,6,7,8,9],
      {6,0} => [1,2,3,4,5,6,7,8,9],
      {7,0} => [1,2,3,4,5,6,7,8,9],
      {8,0} => [1,2,3,4,5,6,7,8,9],
    }

    assert Sudoku.Algo2.new_values_found(new_map, old_map) === %{
      {8,0} => [8],
    }

  end
  # @tag :pending
  test "no new values found" do

    new_map = %{
      {0,0} => [1],
      {1,0} => [1,2],
      {2,0} => [1,2,3,4,5,6,7,8,9],
      {3,0} => [1,2,3,4,5,6,7,8,9],
      {4,0} => [1,2,3],
      {5,0} => [1,2,3,5,6,7,8,9],
      {6,0} => [1,2,3,4,5,6,7,8,9],
      {7,0} => [1,2,3,4,5,6,7,8,9],
      {8,0} => [8],
    }

    assert Sudoku.Algo2.new_values_found(new_map, new_map) === %{}

  end

  # @tag :pending
  test "initial values" do
    map = Sudoku.Algo2.initial_posibilities_to_map
    assert map == %{
      {0,0} => [1,2,3,4,5,6,7,8,9],
      {1,0} => [1,2,3,4,5,6,7,8,9],
      {2,0} => [1,2,3,4,5,6,7,8,9],
      {3,0} => [1,2,3,4,5,6,7,8,9],
      {4,0} => [1,2,3,4,5,6,7,8,9],
      {5,0} => [1,2,3,4,5,6,7,8,9],
      {6,0} => [1,2,3,4,5,6,7,8,9],
      {7,0} => [1,2,3,4,5,6,7,8,9],
      {8,0} => [1,2,3,4,5,6,7,8,9],
      {0,1} => [1,2,3,4,5,6,7,8,9],
      {1,1} => [1,2,3,4,5,6,7,8,9],
      {2,1} => [1,2,3,4,5,6,7,8,9],
      {3,1} => [1,2,3,4,5,6,7,8,9],
      {4,1} => [1,2,3,4,5,6,7,8,9],
      {5,1} => [1,2,3,4,5,6,7,8,9],
      {6,1} => [1,2,3,4,5,6,7,8,9],
      {7,1} => [1,2,3,4,5,6,7,8,9],
      {8,1} => [1,2,3,4,5,6,7,8,9],
      {0,2} => [1,2,3,4,5,6,7,8,9],
      {1,2} => [1,2,3,4,5,6,7,8,9],
      {2,2} => [1,2,3,4,5,6,7,8,9],
      {3,2} => [1,2,3,4,5,6,7,8,9],
      {4,2} => [1,2,3,4,5,6,7,8,9],
      {5,2} => [1,2,3,4,5,6,7,8,9],
      {6,2} => [1,2,3,4,5,6,7,8,9],
      {7,2} => [1,2,3,4,5,6,7,8,9],
      {8,2} => [1,2,3,4,5,6,7,8,9],
      {0,3} => [1,2,3,4,5,6,7,8,9],
      {1,3} => [1,2,3,4,5,6,7,8,9],
      {2,3} => [1,2,3,4,5,6,7,8,9],
      {3,3} => [1,2,3,4,5,6,7,8,9],
      {4,3} => [1,2,3,4,5,6,7,8,9],
      {5,3} => [1,2,3,4,5,6,7,8,9],
      {6,3} => [1,2,3,4,5,6,7,8,9],
      {7,3} => [1,2,3,4,5,6,7,8,9],
      {8,3} => [1,2,3,4,5,6,7,8,9],
      {0,4} => [1,2,3,4,5,6,7,8,9],
      {1,4} => [1,2,3,4,5,6,7,8,9],
      {2,4} => [1,2,3,4,5,6,7,8,9],
      {3,4} => [1,2,3,4,5,6,7,8,9],
      {4,4} => [1,2,3,4,5,6,7,8,9],
      {5,4} => [1,2,3,4,5,6,7,8,9],
      {6,4} => [1,2,3,4,5,6,7,8,9],
      {7,4} => [1,2,3,4,5,6,7,8,9],
      {8,4} => [1,2,3,4,5,6,7,8,9],
      {0,5} => [1,2,3,4,5,6,7,8,9],
      {1,5} => [1,2,3,4,5,6,7,8,9],
      {2,5} => [1,2,3,4,5,6,7,8,9],
      {3,5} => [1,2,3,4,5,6,7,8,9],
      {4,5} => [1,2,3,4,5,6,7,8,9],
      {5,5} => [1,2,3,4,5,6,7,8,9],
      {6,5} => [1,2,3,4,5,6,7,8,9],
      {7,5} => [1,2,3,4,5,6,7,8,9],
      {8,5} => [1,2,3,4,5,6,7,8,9],
      {0,6} => [1,2,3,4,5,6,7,8,9],
      {1,6} => [1,2,3,4,5,6,7,8,9],
      {2,6} => [1,2,3,4,5,6,7,8,9],
      {3,6} => [1,2,3,4,5,6,7,8,9],
      {4,6} => [1,2,3,4,5,6,7,8,9],
      {5,6} => [1,2,3,4,5,6,7,8,9],
      {6,6} => [1,2,3,4,5,6,7,8,9],
      {7,6} => [1,2,3,4,5,6,7,8,9],
      {8,6} => [1,2,3,4,5,6,7,8,9],
      {0,7} => [1,2,3,4,5,6,7,8,9],
      {0,7} => [1,2,3,4,5,6,7,8,9],
      {1,7} => [1,2,3,4,5,6,7,8,9],
      {2,7} => [1,2,3,4,5,6,7,8,9],
      {3,7} => [1,2,3,4,5,6,7,8,9],
      {4,7} => [1,2,3,4,5,6,7,8,9],
      {5,7} => [1,2,3,4,5,6,7,8,9],
      {6,7} => [1,2,3,4,5,6,7,8,9],
      {7,7} => [1,2,3,4,5,6,7,8,9],
      {8,7} => [1,2,3,4,5,6,7,8,9],
      {0,8} => [1,2,3,4,5,6,7,8,9],
      {1,8} => [1,2,3,4,5,6,7,8,9],
      {2,8} => [1,2,3,4,5,6,7,8,9],
      {3,8} => [1,2,3,4,5,6,7,8,9],
      {4,8} => [1,2,3,4,5,6,7,8,9],
      {5,8} => [1,2,3,4,5,6,7,8,9],
      {6,8} => [1,2,3,4,5,6,7,8,9],
      {7,8} => [1,2,3,4,5,6,7,8,9],
      {8,8} => [1,2,3,4,5,6,7,8,9],
    }
  end

  # @tag :pending
  test "apply values" do
    raw = "003020600000000000000000000000000000000000000000000000000000000000000000000000000"
    raw_map = Sudoku.Algo2.input_to_map(raw)
    values = Sudoku.Algo2.initial_posibilities_to_map
    assert Sudoku.Algo2.apply_values(values, raw_map) == %{
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
  test "isolated values row" do
    map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map,
        %{
          {4, 0} => '\b',
          {0, 0} => [2],
          {2, 0} => [5, 7, 9],
          {8, 0} => [1, 5, 6, 7],
          {7, 0} => [1, 5, 7],
          {1, 0} => [1, 4, 5, 7, 9],
          {3, 0} => [4, 9],
          {6, 0} => [3],
          {5, 0} => [1, 4, 9],
        })
    assert Sudoku.Search.search_for_naked_single(map) == %{ {8, 0} => 6}
  end

  # @tag :pending
  test "isolated values col" do
    map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map,
        %{
          {1, 3} => '\a\t',
          {1, 8} => [5, 8, 9],
          {1, 0} => [1, 4, 5, 7, 9],
          {1, 5} => [1, 5, 8, 9],
          {1, 2} => [3],
          {1, 4} => [1, 5, 7, 8, 9],
          {1, 6} => [5, 8, 9],
          {1, 7} => [2],
          {1, 1} => [6],
        })
    assert Sudoku.Search.search_for_naked_single(map) == %{ {1, 0} => 4}
  end

  # @tag :pending
  test "isolated values box" do
    map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map,
    %{
      {0,6} => [3],
      {1,6} => [5,8,9],
      {2,6} => [1],
      {0,7} => [7],
      {1,7} => [2],
      {2,7} => [5,8,9],
      {0,8} => [5,6,8,9],
      {1,8} => [5,8,9],
      {2,8} => [4],
    })
    assert Sudoku.Search.search_for_naked_single(map) == %{ {0, 8} => 6}
  end

  # @tag :pending
  test "isolated values all" do
    map = Map.merge(Sudoku.Algo2.initial_posibilities_to_map,
    %{
      {4, 0} => '\b',
      {0, 0} => [2],
      {2, 0} => [5, 7, 9],
      {8, 0} => [1, 5, 6, 7],
      {7, 0} => [1, 5, 7],
      {1, 0} => [1, 4, 5, 7, 9],
      {3, 0} => [4, 9],
      {6, 0} => [3],
      {5, 0} => [1, 4, 9],
      {1, 3} => '\a\t',
      {1, 8} => [5, 8, 9],
      {1, 0} => [1, 4, 5, 7, 9],
      {1, 5} => [1, 5, 8, 9],
      {1, 2} => [3],
      {1, 4} => [1, 5, 7, 8, 9],
      {1, 6} => [5, 8, 9],
      {1, 7} => [2],
      {1, 1} => [6],
      {0, 6} => [3],
      {1, 6} => [5,8,9],
      {2, 6} => [1],
      {0, 7} => [7],
      {1, 7} => [2],
      {2, 7} => [5,8,9],
      {0, 8} => [5,6,8,9],
      {1, 8} => [5,8,9],
      {2, 8} => [4],
    })
    assert Sudoku.Search.search_for_naked_single(map) == %{ {0, 8} => 6, {1, 0} => 4, {8, 0} => 6 }
  end

  # @tag :pending
  test "isolated values" do
    # only display
    raw = "200080300060070084030500209000105408000000000402706000301007040720040060004010003"
    Sudoku.Algo2.run(raw)
    # Sudoku.Algo2.run(raw, true)
    # only display - end
    blocked_map =
      %{
          {3, 3} => [1],
          {7, 6} => [4],
          {7, 8} => [2, 5, 7, 9],
          {4, 0} => '\b',
          {2, 1} => [5, 9],
          {2, 2} => '\a\b',
          {6, 4} => [1, 5, 6, 7, 9],
          {0, 0} => [2],
          {2, 0} => [5, 7, 9],
          {6, 3} => [4],
          {5, 7} => [3, 8, 9],
          {8, 0} => [1, 5, 6, 7],
          {6, 1} => [1, 5],
          {0, 2} => [1, 8],
          {4, 5} => [3, 9],
          {7, 0} => [1, 5, 7],
          {2, 7} => [5, 8, 9],
          {5, 1} => [1, 2, 3, 9],
          {0, 7} => '\a',
          {7, 1} => '\b',
          {8, 7} => [1, 5],
          {3, 1} => [2, 3, 9],
          {5, 6} => '\a',
          {6, 2} => [2],
          {8, 2} => '\t',
          {1, 3} => '\a\t',
          {6, 8} => [5, 7, 8, 9],
          {1, 8} => [5, 8, 9],
          {5, 4} => [2, 3, 4, 8, 9],
          {7, 4} => [1, 2, 3, 5, 7, 9],
          {3, 5} => '\a',
          {7, 2} => [1, 7],
          {0, 3} => [6, 9],
          {2, 8} => [4],
          {1, 0} => [1, 4, 5, 7, 9],
          {7, 5} => [1, 3, 5, 9],
          {7, 7} => [6],
          {3, 4} => [2, 3, 4, 8, 9],
          {4, 7} => [4],
          {1, 5} => [1, 5, 8, 9],
          {5, 8} => [2, 8, 9],
          {3, 0} => [4, 9],
          {3, 7} => [3, 8, 9],
          {4, 1} => '\a',
          {5, 2} => [1, 4],
          {2, 4} => [3, 5, 6, 7, 8, 9],
          {1, 2} => [3],
          {1, 4} => [1, 5, 7, 8, 9],
          {6, 7} => [1, 5, 8, 9],
          {4, 2} => [6],
          {3, 6} => [2, 6, 8, 9],
          {1, 6} => [5, 8, 9],
          {8, 8} => [3],
          {2, 3} => [3, 6, 7, 9],
          {8, 1} => [4],
          {8, 4} => [1, 2, 5, 6, 7],
          {5, 3} => [5],
          {1, 7} => [2],
          {0, 6} => [3],
          {2, 6} => [1],
          {8, 5} => [1, 5],
          {6, 6} => [5, 8, 9],
          {6, 0} => [3],
          {3, 8} => [2, 6, 8, 9],
          {6, 5} => [1, 5, 9],
          {5, 5} => [6],
          {1, 1} => [6],
          {8, 6} => [2, 5],
          {3, 2} => [5],
          {4, 6} => [2, 5, 9],
          {0, 8} => [5, 6, 8, 9],
          {4, 3} => [2, 3, 9],
          {2, 5} => [2],
          {0, 5} => [4],
          {8, 3} => '\b',
          {0, 4} => [1, 5, 6, 8, 9],
          {4, 4} => [2, 3, 9],
          {4, 8} => [1],
          {5, 0} => [1, 4, 9],
          {0, 1} => [1, 5, 9],
          {7, 3} => [2, 3, 7, 9]
      }

  assert Sudoku.Search.search_for_naked_single(blocked_map) == %{{0, 8} => 6, {1, 0} => 4, {1, 5} => 8, {3, 6} => 6, {4, 6} => 5, {5, 2} => 4, {6, 4} => 6, {8, 0} => 6}

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
  test "get min values by length" do
    blocked_map =
      %{
          {3, 3} => [3, 4, 6],
          {2, 2} => [3, 6, 8, 9],
          {6, 4} => [3, 4, 5, 6, 7, 8],
          {2, 0} => [3, 6, 7, 8],
          {8, 6} => [3, 7, 8],
          {8, 7} => [3, 7, 8],
        }

        mm = blocked_map
        |> Sudoku.DataStructureUtils.get_min_possibilities

        assert mm == [{{8, 7}, [3, 7, 8]}, {{8, 6}, [3, 7, 8]}, {{3, 3}, [3, 4, 6]}]
  end

  # @tag :pending
  test "get min values by length splited" do
    blocked_map =
      %{
          {3, 3} => [3, 4, 6],
          {2, 2} => [3, 6, 8, 9],
          {6, 4} => [3, 4, 5, 6, 7, 8],
          {2, 0} => [3, 6, 7, 8],
          {8, 6} => [3, 7, 8],
          {8, 7} => [3, 7, 8],
        }

        mm = blocked_map
        |> Sudoku.DataStructureUtils.get_min_possibilities
        |> Sudoku.Algo2.split_into_single_element


        assert mm == [
          {{8, 7}, 3},{{8, 7}, 7},{{8, 7}, 8},
          {{8, 6}, 3},{{8, 6}, 7},{{8, 6}, 8},
          {{3, 3}, 3},{{3, 3}, 4},{{3, 3}, 6},
        ]
  end

  # @tag :pending
  test "get no min values by length" do
    blocked_map = %{}

        mm = blocked_map
        |> Sudoku.DataStructureUtils.get_min_possibilities
        |> Sudoku.Algo2.split_into_single_element

        assert mm == []
  end


  # @tag :pending
  test "is_valid?" do
    assert %{"ze" => [1]} |> Sudoku.Validation.is_valid?  == false
  end

  # @tag :pending
  test "is_complete?" do
    assert %{"ze" => [1]} |> Sudoku.Validation.is_complete?  == true
  end

  # @tag :pending
  test "get min length of values" do
    map = %{
              {3, 3} => [3, 4, 6],
              {2, 2} => [3, 6, 8, 9],
              {6, 4} => [3, 4, 5, 6, 7, 8],
              {2, 0} => [3, 6, 7, 8],
              {8, 6} => [3, 7, 8],
              {8, 7} => [3, 7],
            }
    assert map |> Sudoku.DataStructureUtils.get_min_length_of_values  == 2
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
  test "resove simple sudoku" do
    raw = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
    answer = "483921657967345821251876493548132976729564138136798245372689514814253769695417382"
    {:ok, result} = raw |> Sudoku.Algo2.run
    assert result |> Sudoku.Algo2.map_to_raw_data  == answer
  end

  # @tag :pending
  test "resove harder sudoku" do
    raw = "200080300060070084030500209000105408000000000402706000301007040720040060004010003"
    answer = "245981376169273584837564219976125438513498627482736951391657842728349165654812793"

    {:ok, result} = raw |> Sudoku.Algo2.run
    assert result |> Sudoku.Algo2.map_to_raw_data  == answer

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
    |> Sudoku.Algo1.map_to_stack
    |> Sudoku.Algo1.stack_to_map
    assert map == new_map
  end

  # @tag :pending
  # |> Sudoku.Display.pretty
  test "resove harder harder sudoku" do
    raw = "100920000524010000000000070050008102000000000402700090060000000000030945000071006"
    answer = "176923584524817639893654271957348162638192457412765398265489713781236945349571826"
    {_, map} = Sudoku.Algo2.run(raw)

    # map |> Sudoku.Display.pretty

    #
    # min_length = map
    # |> Sudoku.DataStructureUtils.remove_fixed_values
    # |> Sudoku.DataStructureUtils.get_min_length_of_values
    # |> IO.inspect

    # fixed_values = map
    # |> Sudoku.DataStructureUtils.filter_fixed_values(true)
    #
    # multiple_values = map
    # |> Sudoku.DataStructureUtils.remove_fixed_values



    assert Sudoku.Algo1.run(map, :raw) == answer
  end

end
