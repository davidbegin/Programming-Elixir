IO.puts "\ec\e[35;1;4munfold Breakdown\e[0m\n"

# Unraveling /unfold
# ---

# so I want to explore the 3 variables of the return value
# and the 2 values of the input

defmodule Unfolder do
  def unfold(unfold_fn) do
    Stream.unfold({ 0, 1 }, unfold_fn)
    |> Enum.take(10)
  end
end

unfold_fn = fn { f1, f2 } -> { f1, { f2, f2 + 1 } } end

unfold_fn = fn { f1, f2 } ->
  IO.puts "\ec"
  IO.puts "\e[33m{ f1, { f2, f2 + 1 } }\e[0m"
  IO.puts "\e[34m\nf1\nf2\n\e[0m"
  IO.puts String.duplicate(" 0 ", f1)
  IO.puts String.duplicate(" 0 ", f2)
  :timer.sleep(300)
  { f1, { f2, f2 + 1 } }
end

Unfolder.unfold(unfold_fn)


