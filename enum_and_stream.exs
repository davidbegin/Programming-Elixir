
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


