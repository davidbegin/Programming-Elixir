
defmodule S do
  def s, do: IO.puts "\n------\n"
end

list = Enum.to_list 1..9
IO.inspect list

S.s

Enum.concat([1, 2, 3], 'abc')
|> IO.inspect

Enum.map(list, &( &1 * 10 ))
|> IO.inspect

Enum.map(list, &String.duplicate("*", &1))
|> IO.inspect

S.s

Enum.at(0..10, 2)
|> IO.inspect

Enum.at(0..10, 11)
|> IO.inspect

Enum.at(0..10, 11, :no_eleven_here)
|> IO.inspect

S.s

list = [ 1, 2, 3, 4, 5, 6 ]
Enum.filter(list, &(  &1 > 3 ))
|> IO.inspect

require Integer

Enum.filter(list, &Integer.is_even/1)
|> IO.inspect

Enum.reject(list, &Integer.is_odd/1)
|> IO.inspect

S.s

result = Enum.sort [ "david", "begin", "michael" ]
IO.inspect result

result = Enum.sort [ "dave", "begin", "michael" ],
&( String.length(&1) < String.length(&2) )
IO.inspect result

result = Enum.max ["woah", "a", "koto", "hufflepuff", "lamp-shade"]
IO.inspect result

result = Enum.max_by ["woah", "a", "koto", "hufflepuff", "lamp-shade"],
  &( String.length(&1) )
IO.inspect result

Enum.take(list, 3)
|> IO.inspect

Enum.take_every(list, 2)
|> IO.inspect

Enum.take_while(list, &( &1 < 6 ))
|> IO.inspect

Enum.split(list, 2)
|> IO.inspect

Enum.split_while(list, &( &1 < 4) )
|> IO.inspect

Enum.join(list)
|> IO.inspect

Enum.join(list, " | ")
|> IO.inspect

Enum.all?(list, &(&1>0))
|> IO.puts

Enum.any?(list, &(&1>4))
|> IO.puts

Enum.member?(list, 6)
|> IO.puts

Enum.empty?([]) |> IO.puts

# Notice how this ignores, values that don't have a zip pair
Enum.zip(list, [:a, :b, :c, :d]) |> IO.inspect

list = ["one", "two", "three", "four"]
Enum.with_index(list) |> IO.inspect

Enum.reduce(1..100, &(&1+&2)) |> IO.inspect

S.s

Enum.reduce(["now", "is", "the", "time"], fn word, longest ->
  if String.length(word) > String.length(longest) do
    word
  else
    longest
  end
end) |> IO.puts

Enum.reduce(["now", "is", "the", "time"], 0, fn word, longest ->
  if String.length(word) > longest do
    String.length(word)
  else
    longest
  end
end) |> IO.puts

S.s

import Enum

deck = for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit, rank]

deck |> shuffle |> take(13) |> IO.inspect

S.s

hands = deck |> shuffle |> chunk(13)
IO.inspect hands
