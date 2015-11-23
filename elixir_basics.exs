IO.puts "Elixir Basics"
IO.puts "---"

# Value Types:
#   * Numbers
#   * Names
#   * Ranges
#   * Regular Expressions

# This list confuses me because of 2 reasons:
# I do now know what names are,
# and Regular expressions as value types feels wrong to me,
# but I don't really know what Value type means!

# Numbers:
#   * Decimal
#   * Hexadecimal
#   * Octal
#   * Binary

IO.puts "Decimal: #{512}"
IO.puts "Hexadecimal: #{0x0200}"
IO.puts "Octal: #{0o1000}"
IO.puts "Binary: #{0b1000000000}"
IO.puts "Big Ole Numbers: #{100_000_000_000}"
IO.puts "Float!: #{99.44323423423859843}"

# Atoms are like Symbols
# but how are they different?

IO.puts "\n\nAtoms:"
IO.puts "---"
IO.puts :hello
IO.puts :"hello?"
IO.puts :"__^^/@hell/^%$#o?"

IO.puts "\n\nRanges"
IO.puts "---"
range = 10..100
IO.inspect range

IO.puts "Regular Expressions"
IO.puts "---"
IO.inspect Regex.run ~r{[dvo]}, "devo"
IO.inspect Regex.scan ~r{[dvo]}, "devo"
IO.inspect Regex.split ~r{[v]}, "devo"
