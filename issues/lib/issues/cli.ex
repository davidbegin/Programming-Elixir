defmodule Issues.CLI do

  # Don't know what this is for
  @default_count 4

  # I think these triple strings are heredocs?
  # and I am not sure what @moduledoc is for
  #
  # ...actually I don't know what @anything are for!
  # I was thinking of them as instance variables
  @moduledoc """
  Handle the comme line parsing and the dispatch to
  the various functions that end up generating a=
  table of the kast _n_ issues ina  github project
  """

  def run(argv) do
    argv
      |> parse_args
      |> process
  end

  # Ok so maybe they have something to do with the
  # type of documentation they are
  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or  `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])

    case parse do
      { [ help: true ], _, _ }
        -> :help

      { _, [ user, project, count ], _ }
        -> { user, project, count }

      { _, [ user, project  ], _ }
        -> { user, project, @default_count }

      _ -> :help
    end
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
  end

  # Man I love this defining functions multiple times for different arguments
  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

end
