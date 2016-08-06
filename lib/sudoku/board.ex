defmodule Sudoku.Board do

    @doc """
    generate coordinates for columns
        [[{0,0},{0,1},{0,2},{0,3},{0,4},{0,5},{0,6},{0,7},{0,8},],...]
    """
    def generate_board_columns(size \\ 9) do
      Enum.reduce(0..size - 1, [], fn(abs,acc) ->
        col = Enum.reduce(0..size - 1, [], fn(ord, accu) ->
          [{abs,ord}|accu]
        end)
        |> Enum.reverse
        [col | acc]
      end)
      |> Enum.reverse
    end

    @doc """
    generate coordinates for rows
        [[{0,0},{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0},{8,0},],...]
    """
    def generate_board_rows(size \\ 9) do
      Enum.reduce(0..size - 1, [], fn(ord,acc) ->
        col = Enum.reduce(0..size - 1, [], fn(abs, accu) ->
          [{abs,ord}|accu]
        end)
        |> Enum.reverse
        [col | acc]
      end)
      |> Enum.reverse
    end

    @doc """
    generate coordinates for boxes
        [[{0,0},{0,1},{0,2},{1,0},{1,1},{1,2},{2,0},{2,1},{2,2}],...]
    """
    def generate_board_boxes(size \\ 3) do
      range = Enum.slice([0..2, 3..5, 6..8], 0..size - 1 )

      Enum.reduce(range, [], fn(r_ord,acc) ->
        col_boxes = Enum.reduce(range, [], fn(r_abs, accu) ->
          comp = for x <- r_abs,
                     y <- r_ord,
                     do: {x,y}
          [comp | accu]
        end)
        |> Enum.reverse
        acc ++ col_boxes
      end)
    end

    @doc """
    Return coordinates of the box
        {5,5} -> [{3,3},{3,4},{3,5},{4,3},{4,4},{4,5},{5,3},{5,4},{5,5}]
    """
    def get_box_coordinates(tuple) do
      Enum.find(generate_board_boxes, fn(boxe) ->
        Enum.member?(boxe, tuple)
      end)
    end

    @doc """
    Return coordinates of the column
        3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
    """
    def get_col_coordinates(col_num) do
      Enum.at(generate_board_columns, col_num)
    end

    @doc """
    Return coordinates of the row
        3 -> [{3,0},{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},{3,7},{3,8}]
    """
    def get_row_coordinates(row_num) do
      Enum.at(generate_board_rows, row_num)
    end
end
