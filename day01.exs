#!/usr/bin/env elixir

{a, b} =
  "./input/day01.txt"
  |> File.stream!()
  |> Stream.map(&String.trim/1)
  |> Enum.to_list()
  |> Enum.reduce({[], []}, fn s, {a, b} ->
    [x, y] = String.split(s, " ", trim: true)
    {[String.to_integer(x) | a], [String.to_integer(y) | b]}
  end)

# Part one
List.zip([Enum.sort(a), Enum.sort(b)])
|> Enum.map(fn {x, y} -> abs(x - y) end)
|> Enum.sum()
|> IO.inspect()

# Part two
f = Enum.frequencies(b)

a
|> Enum.filter(fn x -> f[x] end)
|> Enum.map(fn x -> x * f[x] end)
|> Enum.sum()
|> IO.inspect()
