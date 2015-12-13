# Lists and Recursion
# ---

# I think it is very useful to first view lists, always as heads and tails.

shorthand = [1, 2, 3]
longform  = [ 1 | [ 2 | [ 3 | [] ] ] ]
IO.puts "[ 1, 2, 3 ] == [ 1 | [ 2 | [ 3 | [] ] ] ]: #{shorthand == longform}"

# so the first thing that is weird when I work with this list,
# is I need a module and functions, I feel like there should be a way,
# (really I am just expecting .each like in ruby!)

# So it has made be realize, for now, I am going to make a concious decision
# to immediately it make a module, and start with functions.
# This is the re-programming, I need!

# This immeaditely makes me think what should these modules
# be named after, but that is me jumping ahead!

# I would really like a long list of exercise to get my mind thinking
# right about lists and recursion.

# Exercise 1

# Find the length of a list

defmodule LengthFinder do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + length(tail)
end

LengthFinder.len([1, 2, 3])
|> IO.puts

# the comma and colon are confusing me on functions
# So I am going to start using them more librelly,
# as well as try and write the short hand more,
# my ruby-tendencies want me to write them out with do...end
# but I'm trying to break habits

# Exercise 2

# Square each number

defmodule Squarer do
  def square([]) do
    []
  end

  def square([ head | tail ]) do
    [ head*head | square(tail) ]
  end
end

# Whenever you are writing functions that are processing over a list,
# it will always take the form of two functions.

# the first, is the ending function,
# matching an empty list, to end the processing at the end of the list.
# and will return an empty list.

# the other will process each element,
# so it will always take the head | tail,
# to split the head, which it will transform,
# and add to the new list that is being constructed,
# and processing the tail of the list.

# this is always much easier to understand, if you really
# think of lists as heads and tails

fn_result1 = Squarer.square([1, 2, 3])
fn_result2 = Squarer.square([1 | [ 2 | [3 | [] ] ] ])
IO.puts fn_result1 == fn_result2

step1 = [ 1*1 | Squarer.square( [ 2 | [ 3 | [] ] ] ) ]
step2 = [ 1  | [ 2*2 | Squarer.square( [ 3 | [] ] ) ] ]
step3 = [ 1  | [ 4   | [ 3*3 | Squarer.square( [] ) ] ] ]
step4 = [ 1  | [ 4   | [ 9   | [] ] ] ]
step5 = [ 1 | [ 4 | [ 9 | [] ] ] ]
step6 = [ 1, 4, 9 ]

IO.puts step1 == step2
IO.puts step2 == step3
IO.puts step3 == step4
IO.puts step4 == step5
IO.puts step5 == step6

# Exercise 3

# add 1 to each number in the list

defmodule AddOne do
  def call([]), do: []
  def call([ head | tail ]) do
    [ head + 1 | call(tail) ]
  end
end

IO.inspect AddOne.call([2, 3, 5, 6])

# https://en.wikipedia.org/wiki/Anaximander
defmodule Anaximander do
  def map([], _func) do
    []
  end

  def map([head | tail], func) do
    [ func.(head) | map(tail, func) ]
  end
end

Anaximander.map([1, 2, 3], fn (n) -> n*n end)
|> IO.inspect

Anaximander.map([1, 2, 3, 4, 5, 6], fn (n) -> (rem(n, 2) == 0) end)
|> IO.inspect

Anaximander.map([1, 2, 3], &(&1*&1) )
|> IO.inspect

Anaximander.map([1, 2, 3, 4, 5, 6], &( rem(&1, 2) == 0) )
|> IO.inspect

Anaximander.map([1, 2, 3, 4, 5, 6], &( rem(&1, 2) == 0) )
|> IO.inspect

# sometimes it is easier to visualize on the map when looking
# and the long form version of a list.
Anaximander.map([1 | [ 2 | [ 3 | [] ] ] ] , &( rem(&1, 2) == 0) )
|> IO.inspect

# Syntax revolution!
# , and : are required for 1 line, and forbidden for two!
# I actually like that better, less decisions to be made


defmodule Summer do
  def sum([], total), do: total
  def sum([ head | tail ], total) do
    sum(tail, head + total)
  end
end

Summer.sum([1, 2, 3], 0)
|> IO.inspect

defmodule SummerV2 do
  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head + total)
end

SummerV2.sum([1, 2, 3])
|> IO.inspect

defmodule Reducer do
  def reduce([], total, _func), do: total
  def reduce([ head | tail ], total, func) do
    reduce(tail, func.(head, total), func)
  end
end

Reducer.reduce([1, 2, 3], 0, &(&1 + &2) )
|> IO.inspect

# List and Recursion Exercises:

# 1. Write a mapsum function that takes a list and a function.
# It apples the function to each element of the list and then sums the result so:
# MyList.mapsum [1, 2, 3], &(&1 * &1)

defmodule MapEndlessSummer do
  def mapsum(list, func) do
    _map(list, func)
      |> _sum(0)
  end

  defp _map([], _func), do: []
  defp _map([ head | tail ], func) do
    [ func.(head) | _map(tail, func) ]
  end

  defp _sum([], total), do: total
  defp _sum( [ head | tail ], total) do
    _sum(tail, head + total)
  end
end

# MapEndlessSummer.mapsum([1, 2, 3], fn (x) -> x * 10 end)
MapEndlessSummer.mapsum([1, 2, 3], &( &1 * 10))
|> IO.inspect

# 2. Write a max(list) that returns the element with the maximum value in the list

# So can I replace the total value with the max value and
# continue rescurisvely comparing it, to the previous value
defmodule MaxFinder do
  def max(list) do
    _max(list, 0)
  end

  defp _max([], max), do: max
  defp _max([ head | tail ], max) do
    new_max = if head > max, do: head, else: max
    _max(tail, new_max)
  end
end

MaxFinder.max([1, 2, 3, 4])
|> IO.inspect

# 3. Write a caesar(list, n) function that adds n to each list element,
# wrapping if the addition results in a character greater than z.
# MyList.caesar("ryvkve", 13)

# So I a need all whole alphabet

defmodule CaesarCipher do
  def caesar(list, n) do
    alphabet = 'abcdefghijklmnopqrstuvwxyz'

    _caesar(list, n, alphabet)
      |> IO.inspect
  end

  def _caesar( [] , _n, _alphabet ), do: []

  def _caesar( [ head | tail ], n, alphabet ) do
    new_position = (:string.chr(alphabet, head) - 1) + n
      |> rem(26)

    [ Enum.at(alphabet, new_position) | _caesar(tail, n, alphabet) ]
  end
end

IO.puts "\n\n=======\n\n"

CaesarCipher.caesar('hello', 27)








# OFFTOPIC
# why do functions have to be scoped to modules?
# is it just not to liter the global namespace?

