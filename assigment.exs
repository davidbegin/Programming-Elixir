IO.inspect "\n=================="
IO.inspect "The Match Operator"
IO.inspect "==================\n"

# So "=" is not what I am used to, it is not for assignment,
# but for pattern matching

# it is actual called the match operator

# so when ever an match operator is present, Elixir is going
# to try and find a way to make both sides match.

# However, it is not the simple.
# Which side on the match operator you are on, changes how you function when pattern matching.

# Variables on the left side of the match operator, can be assigned, to a value
# on the right

a = 1
IO.inspect "---"
IO.inspect a # => 1

# to make this match work, we can just assign the value of 1 to a,
# and BOOM! we have a match.

# this only works because a is on the left side.
# Here's what happens when the unassigned variable is on the right side

# 1 = b # => ** (CompileError) assigment.exs:28: undefined function b/0

# what happens if the variable on the left side is already assigned to something?

a = 2
IO.inspect "---"
IO.inspect a # => 2
# It just reassigns a!

# So the match works, as long as the variables on the left, can map to right.

[a, b] = [1, 2]
IO.inspect "---"
IO.inspect a # => 1
IO.inspect b # => 2

# [a, b] = [1, 2, 3] # => ** (MatchError) no match of right hand side value: [1, 2, 3]

[a, b] = [1, [2, 3]]
IO.inspect "---"
IO.inspect a # => 1
IO.inspect b # => [2, 3]

# You can also have actual values on the left side,
# that need to be matched

[a, 2, b] = [1, 2, 3]
IO.inspect "---"
IO.inspect a # => 1
IO.inspect b # => 3

# [a, 9, b] = [1, 2, 3] # => ** (MatchError) no match of right hand side value: [1, 2, 3]


a = [1, 2, 3] # => [1, 2, 3]
a = 4 # => 4
4 = a # => 4
# [a, b] = [1, 2, 3] # => ** (MatchError) no match of right hand side value: [1, 2, 3]
a = [[1, 2, 3]] # => [[1, 2, 3]]
[a] = [[1, 2, 3]] # => [1, 2, 3]
# [[a]] = [[1, 2, 3]] # => ** (MatchError) no match of right hand side value: [[1, 2, 3]]

IO.puts "---\n"

# Underscores can used like wildcards, for variables you don't care about

[a, _, 4] = [10, "Dog", 4]
IO.inspect "---"
IO.inspect a

# [a, b, a] = [1, 2, 3] => FAIL
# [a, b, a] = [1, 1, 2] # => FAIL
[a, b, a] = [1, 2, 1] # => PASS

a = 1
[a, b, a] = [2, 3, 2]
IO.puts "---"
IO.inspect a
[a, ^b, a] = [1, 3, 1]
IO.inspect b
# [a, ^b, a] = [1, 9, 1] # => ** (MatchError) no match of right hand side value: [1, 9, 1]

