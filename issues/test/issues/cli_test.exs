defmodule CliTest do
  use ExUnit.Case

  # what is this mysterious 1 after parse args?
  import Issues.CLI, only: [ parse_args: 1 ]

  test ":help returned with -h and --help options" do
    assert parse_args(["-h", "blah"]) == :help
    assert parse_args(["--help", "blah"]) == :help
  end

  test "3 options are returned when 3 options passed" do
    assert parse_args(["davidbegin", "downup", 10]) == {"davidbegin", "downup", 10}
  end

  test "3 options, 1 being a default are returned when passed 2 options" do
    assert parse_args(["davidbegin", "downup"]) == {"davidbegin", "downup", 4}
  end

end
