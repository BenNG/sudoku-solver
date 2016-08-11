defmodule BoardBench do
  use Benchfella

  bench "get coordinates of column number 3 - first impl" do
    Enum.reduce((9 - 1)..0, [], fn(n, acc) ->
      [{n, 3} | acc]
    end )
  end

  bench "get coordinates of column number 3 - second impl" do
    for abs <- 0..(9 - 1),
        do: {abs, 3}
  end
end
