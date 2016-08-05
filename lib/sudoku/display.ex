defmodule Sudoku.Display do

  def pretty(map, display_coor \\ true) do
    IO.puts ""
    size_item = if display_coor, do: 16, else: 10

    draw_line(size_item)

    Sudoku.Algo2.order
    |> Enum.chunk(27,27)
    |> Enum.each(fn(block) ->
      block
      |> Enum.chunk(9,9)
      |> Enum.each(fn(list) ->
          IO.write " | "
          Enum.chunk(list, 3,3)
          |> Enum.each(fn(items) ->
              Enum.each(items, fn(tuple) ->
                pretty_item(map, tuple, display_coor)
              end)
          IO.write " | "
          end)
          IO.puts ""
      end)

      draw_line(size_item)

    end)
  end

  def pretty_item(map, tuple, display_coor) do
    coor = if display_coor, do: String.pad_trailing("{#{elem(tuple,0)},#{elem(tuple,1)}}", 6), else: ""
    size_item = if display_coor, do: 16, else: 10
    v = Map.get(map, tuple, [1,2,3,4,5,6,7,8,9])
    IO.write String.pad_trailing("#{coor}#{Enum.join(v)}", size_item)
  end

  def draw_line(size_item) do
    IO.write " | "
    0..2
    |> Enum.each(fn(_) ->
      0..2
      |> Enum.each(fn(_) ->
        String.duplicate("-", size_item) |> IO.write
      end)
      IO.write " | "
    end)
    IO.puts ""
  end

end
