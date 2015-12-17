
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

S.s

# Implemnt the following for a new Enum:
# all?
# each
# filter
# split
# take

# all?

defmodule NewAndImprovedEnum do
  def all?(list, func) do
    all_compiled = true
    _all?(list, func, all_compiled)
  end

  def _all?([], _func, all_compiled), do: all_compiled
  def _all?([ head | tail ], func, all_compiled) do
    result = func.(head)
    if result == false do
      all_compiled = false
    end
    _all?(tail, func, all_compiled)
  end
end

# So how does all? work?
# I need to go through each element of the list recusivly and check if it fulfils the anon
# function

list = [1, 2, 3, 4]
result = NewAndImprovedEnum.all?( list, &( &1 > 2 ) )
IO.inspect result
result = NewAndImprovedEnum.all?( list, &( &1 > 0 ) )
IO.inspect result

S.s

# each

defmodule NewAndImprovedEnum do
  def each(list, func) do
    _each(list, func)
  end

  def _each([], _func), do: []
  def _each([ head | tail ], func) do
    [ func.(head) | _each(tail, func) ]
  end
end

list = [1, 2, 3, 4, 5]
NewAndImprovedEnum.each( list, &( &1 * 10 ) )
|> IO.inspect

S.s

# filter

defmodule NewAndImprovedEnum do
  def filter(list, func) do
    _filter(list, func)
  end

  def _filter([], _func), do: []
  def _filter([ head | tail ], func) do
    if func.(head) == false do
      _filter(tail, func)
    else
      [  head | _filter(tail, func) ]
    end
  end
end

list = [1, 2, 3, 4, 5]
NewAndImprovedEnum.filter( list, &Integer.is_even(&1) )
|> IO.inspect

S.s

# split

defmodule NewAndImprovedEnum do
  def split(list, split_index) do
    _split(list, split_index, 0, [], [])
  end

  defp _split([], _split_index, _index, front, back), do: { front, back }
  defp _split([ head | tail ], split_index, index, front, back) do
    sort_item_into_place(head, tail, split_index, index, front, back)
  end

  defp sort_item_into_place(head, tail, split_index, index, front, back) when index < split_index do
    _split(tail, split_index, index + 1, [ head | front ], back)
  end
  defp sort_item_into_place(head, tail, split_index, index, front, back) when index >= split_index do
    _split(tail, split_index, index + 1, front, [ head | back ])
  end
end

list = [1, 2, 3, 4, 5]
NewAndImprovedEnum.split( list, 2 )
|> IO.inspect

S.s

# take

defmodule NewAndImprovedEnum do
  def take(list, num) do
    _take(list, num, [], 0)
  end

  def _take([], num, acc, index), do: acc
  def _take([ head | tail ], num, acc, index) do
    if index <= num do
      _take(tail, num, acc ++ [head], index + 1)
    else
      _take([], num, acc, index)
    end
  end
end

list = [1, 2, 3, 4, 5, 6, 7, 8]
NewAndImprovedEnum.take(list, 5) |> IO.inspect
