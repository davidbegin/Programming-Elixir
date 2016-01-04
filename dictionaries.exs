# Chapter 8: Dictionaries

# when trying to decide between a Map, HashDict or Keywords
# Ask your self the following questions in order:

# 1. Will I want more than on entry with the same key?
# => use the Keyword module

# 2. Do I need to guarantee the elements are ordered?
# => use the Keyword module

# 3. Do I want to pattern match against the contents
# (for example, matchng a dictionary that has a key of :name somehere in it)
# => use a Map

# 4. Will I be storing more than a few hundred entries in it?
# Use a HashDict

defmodule Sum do
  def values(dict) do
    dict |> Dict.values |> Enum.sum
  end
end


# Summing a HashDict
hd = [ one: 1, two: 2, three: 3, four: 4 ]
Sum.values(hd) |> IO.inspect

# Summing a Map
map = %{ four: 5, five: 5, six: 6 }
Sum.values(map) |> IO.inspect
