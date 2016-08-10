defmodule Sudoku.Display do

  def pretty(map, are_coord_displayed? \\ true) do
    IO.puts ""
    size_item = if are_coord_displayed?, do: 16, else: 10

    # the 81 ordered coordinates
    ordered_coords = Sudoku.Board.generate_rows |> List.flatten
    list_of_3_each_27_coords = Enum.chunk(ordered_coords, 27, 27)

    draw_separation_line(size_item)

    Enum.each(list_of_3_each_27_coords, fn(list_of_27_coords) ->
      list_of_3_each_9_coords = Enum.chunk(list_of_27_coords, 9, 9)
      Enum.each(list_of_3_each_9_coords, fn(line) ->
        draw_line(map, line, are_coord_displayed?)
      end)

      draw_separation_line(size_item)
    end)
  end

  def draw_item(map, tuple, true) do
    coor = draw_tuple(tuple)
    v = Map.get(map, tuple, Integer.digits(123456789))
    IO.write String.pad_trailing("#{coor}#{Enum.join(v)}", 16)
  end

  def draw_item(map, tuple, false) do
    v = Map.get(map, tuple, Integer.digits(123456789))
    IO.write String.pad_trailing("#{Enum.join(v)}", 10)
  end

  # removing the space introduce by inspect when puting
  def draw_tuple({a,b}) do
    String.pad_trailing("{#{a},#{b}}", 6)
  end

  def draw_line(map, list_of_9_coords, are_coord_displayed?) do
    list_of_3_each_3_coords = Enum.chunk(list_of_9_coords, 3,3)

    draw_vertical_char
    Enum.each(list_of_3_each_3_coords, fn(list_of_3_coords) ->
        Enum.each(list_of_3_coords, &(draw_item(map, &1, are_coord_displayed?)))
        draw_vertical_char
    end)
    IO.puts ""
  end

  def draw_vertical_char, do: IO.write " | "
  def draw_separation_line(size_item) do
    draw_vertical_char
    Enum.each(0..2, fn(_list_of_3_each_3_coords) ->

      Enum.each(0..2, fn(_list_of_3_coords) ->
        IO.write(String.duplicate("-", size_item))
      end)
      draw_vertical_char

    end)
    IO.puts ""
  end

end
