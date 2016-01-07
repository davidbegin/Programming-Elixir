# Working with Multiple Processes
# ---

# An actor is an independent process that shares nothing with any other processes.

# The processes we are talking about here, are not operating system processes,
# but Erlang processes, much more lightweight.

defmodule Greeter do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
    end
  end
end

# so first we spawn a new process, for the module Greeter
# the function greet and no arguments
pid = spawn(Greeter, :greet, [])

# We then send a message to process, passing in the sender
# and a message
send pid, { self, "World!" }

# but nothing will visible will happen. until....

# We then have to wait for this response to come

# which we know will be a two element tuple
# with :ok being the first

# So the message returned form Greeter.greet will be outputed to console
receive do
  {:ok, msg} ->
    IO.puts msg
end

# -----------------------------------------------


