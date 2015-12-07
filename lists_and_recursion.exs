# I think it is very useful to first view list's always as
# heads and tails.

# AKA

shorthand = [1, 2, 3]
longform  = [ 1 | [ 2 | [ 3 | [] ] ] ]
IO.puts "[ 1, 2, 3 ] == [ 1 | [ 2 | [ 3 | [] ] ] ]: #{shorthand == longform}"

# so the first thing that is wierd when I work with this list,
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

# Syntax revolution!
# , and : are requried for 1 line, and forbidden for two!
# I actually like that better, less decisions to be made


# OFFTOPIC
# why do functions have to be scoped to modules?
# is it just not to liter the global namespace?

