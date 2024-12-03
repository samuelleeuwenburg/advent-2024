#!/usr/bin/env elixir

reports =
  "./input/day02.txt"
  |> File.stream!()
  |> Stream.map(&String.trim/1)
  |> Enum.to_list()
  |> Enum.map(fn s ->
    s |> String.split(" ", trim: true) |> Enum.map(fn s -> String.to_integer(s) end)
  end)

# Part one
reports
|> Enum.map(fn l ->
  Enum.reduce(tl(l), {true, hd(l)}, fn y, {r, x} ->
    a = if hd(l) < List.last(l), do: x <= y, else: x >= y
    b = abs(x - y) > 0 && abs(x - y) < 4
    {r && a && b, y}
  end)
end)
|> Enum.filter(fn {b, _} -> b end)
|> length
|> IO.inspect()

# Part two
reports
|> Enum.map(fn l ->
  [{l, true}, {Enum.reverse(l), true}, {l, false}, {Enum.reverse(l), false}]
  |> Enum.map(fn {l, s} ->
    Enum.reduce(tl(l), {true, false, hd(l)}, fn y, {r, f, x} ->
      case {
        if(s, do: x < y, else: x > y) &&
          abs(x - y) > 0 && abs(x - y) < 4,
        f
      } do
        {false, false} -> {true, true, x}
        {false, true} -> {false, true, y}
        {true, _} -> {r, f, y}
      end
    end)
  end)
  |> Enum.any?(fn {b, _, _} -> b end)
end)
|> Enum.filter(& &1)
|> length
|> IO.inspect()
