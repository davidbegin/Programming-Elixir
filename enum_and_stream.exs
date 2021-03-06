
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

S.s

# Write a flatten(list) function that takes a list that may contain any
# number of sublists, which themselves may contain sublists, to any depth
# it returns the elements of these lists as a flat list.

# MyList.flatten([ 1, [ 2, 3, [4] ], 5], [[[[6]]]])
# [1, 2, 3, 4, 5, 6]


# UNDER CONSTRUCTION
defmodule NewAndImprovedEnum do
  def flatten(list) do
    _flatten(list, [])
  end

  # I am not sure what to do!
  defp _flatten([], acc), do: acc
  defp _flatten([ [ head | tail ] | tail ], acc) do
  end
  defp _flatten([ head | tail ], acc) do
    # So I need to continue unwrapping a value until its no longer an array,
    # once its a value, we add it to the acc
  end
end

# might need Enum.reverse

NewAndImprovedEnum.flatten([ 1, [ 2, 3, [4] ], 5, [[[[6]]]]])
|> IO.inspect

S.s

[1, 2, 3, 4, 5]
|> Enum.map(&(&1*&1))
|> Enum.with_index
|> Enum.map(fn { value, index } -> value - index end)
|> IO.inspect

S.s

# IO.puts File.read!("/usr/share/dict/words")
# |> String.split
# |> Enum.max_by(&String.length/1)

S.s

squares = Stream.map [1, 2, 3], &(&1*&1)
add_one = Stream.map squares, &(&1 + 1)
cubes   = Stream.map add_one, &(&1*&1*&1)
cubes |> IO.inspect

result = Enum.to_list cubes
IO.inspect result

S.s

# Commented out to not have to wait for other scripts
# IO.puts File.open!("/usr/share/dict/words")
# |> IO.stream(:line)
# |> Enum.max_by(&String.length/1)
#
# IO.puts File.stream!("/usr/share/dict/words")
# |> Enum.max_by(&String.length/1)

S.s

# Commented out to not have to wait for other scripts
# Enum.map(1..10_000_000, &(&1+1)) |> Enum.take(5) |> IO.inspect
#
# Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5) |> IO.inspect

S.s

[1, 2, 3, 4, 5]
|> Stream.map(&(&1*&1))
|> Enum.with_index
|> Stream.map(fn { value, index } -> value - index end)
|> IO.inspect

S.s

# Stream.cycle(["green", "white"])
Stream.cycle(~w{ green white })
  |> Stream.zip(1..5)
  |> Enum.map(fn {class, value} -> ~s{<tr class="#{class}"><td>#{value}</td></tr>\e} end )
  |> IO.inspect

S.s

Stream.repeatedly(fn -> true end) |> Enum.take(5) |> IO.inspect

S.s

Stream.iterate(0, &(&1+1))  |> Enum.take(5) |> IO.inspect
Stream.iterate(2, &(&1*&1)) |> Enum.take(5) |> IO.inspect
Stream.iterate([], &([&1])) |> Enum.take(5) |> IO.inspect

S.s

# So unfold is a little more complicated
# the general form it takes is:

# fn state -> { stream_value, new_statue } end

# the state is a tuple of the current number and next number in the sequence

Stream.unfold({0,1}, fn {f1, f2} -> {f1, {f2, f1+f2}} end)
|> Enum.take(15)
|> IO.inspect

# Lets try and unpack unfold a little more

# So we need to supply it with the current number and next number in the sequence,
# and then it is going to be passed to unfold

# lets unpack the function
fn { f1, f2 } -> { f1, { f2, f1 + f2 } } end

# so do functions passed to unfold, always need to take a tuple of two?

# and what do functions need to return,
# this one returns { 0, { 1, 1 } }

S.s

IO.puts "\e[35;1;4munfold Breakdown\e[0m\n"

defmodule Unfolder do
  def unfold(unfold_fn) do
    Stream.unfold({ 0, 1 }, unfold_fn)
    |> Enum.take(10)
    |> IO.inspect
  end
end

unfold_fn = fn { f1, f2 } -> { f1, { f2, f2 + 1 } } end
Unfolder.unfold(unfold_fn)

unfold_fn = fn { f1, f2 } -> { f1 + 1, { f2, f2 + 1 } } end
Unfolder.unfold(unfold_fn)

unfold_fn = fn { f1, f2 } -> { f1 + 1, { f2, f2 + 5 } } end
Unfolder.unfold(unfold_fn)

unfold_fn = fn { f1, f2 } -> { f1, { f2, f2 - 1 } } end
Unfolder.unfold(unfold_fn)

S.s

stream = Stream.unfold("hełło", &String.next_codepoint/1)
|> Enum.take(4)
|> IO.inspect

S.s

resource = Stream.resource(fn -> File.open("README.md") end,
  fn file ->
    case IO.read(file, :line) do
      line when is_binary(line) -> { [line], file }
      _ -> {:halt, file}
    end
  end,
  fn file -> File.close!(file) end)

# So Stream.resource takes 3 arguments

# a function for opening the resource,
# what do do with the resource
# how to close the connection to the resource

open_func = fn -> File.open("README.md") end

work_func = fn file ->
   case IO.read(file, :line) do
     line when is_binary(line) -> { [line], file }
     _ -> {:halt, file}
   end
  end

close_func = fn file -> File.close!(file) end

resource = Stream.resource(open_func, work_func, close_func)

defmodule Countdown do
  def sleep(seconds) do
    receive do
      after seconds*1000 -> nil
    end
  end

  def say(text) do
    spawn fn -> :os.cmd('say #{text}') end
  end

  def timer do
    Stream.resource(
      fn ->
        { _h, _m, s } = :erlang.time
        60 - s - 1
      end,


      fn
        0 ->
          { :halt, 0 }

          count ->
            sleep(1)
            { [inspect(count)], count - 1 }
      end,

      fn _ -> end
    )
  end
end

counter = Countdown.timer

printer = counter |> Stream.each(&IO.puts/1)

speaker = printer |> Stream.each(&Countdown.say/1)

speaker |> Enum.take(3)
