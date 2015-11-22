IO.puts "\n=================="
IO.puts "The Match Operator"
IO.puts "==================\n"

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
IO.puts a

# to make this match work, we can just assign the value of 1 to a,
# and BOOM! we have a match.

# this only works because a is on the left side.
# Here's what happens when the unassigned variable is on the right side

# 1 = b
# ** (CompileError) assigment.exs:28: undefined function b/0

