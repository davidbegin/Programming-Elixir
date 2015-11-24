IO.puts "Immutability"
IO.puts "---"

IO.puts String.capitalize "mr. elixir"

list = [1, 2, 3]
new_list = [99 | list]
IO.inspect new_list
