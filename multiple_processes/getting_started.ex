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

IO.puts "\n=====================================\n"

defmodule Greeter2 do
  def greet do
    receive do
      { sender, msg } ->
        send sender, { :ok, "Hello there, #{msg}" }
    end
  end
end

pid = spawn(Greeter2, :greet, [])

send pid, { self, "I'm sending messages" }

receive do
  { :ok, msg } ->
    IO.puts msg
end

send pid, { self, "I'm sending a second message" }

# This will timeout, because Greeter2 only knows how to handle a single
# message, and then it exits, meaning another message will never
# be received.

# so after, takes care of just moving on after waiting a
# specified amount of time. In this case 500 ms
receive do
  { :ok, msg } ->
    IO.puts msg
after 500 ->
  IO.puts "Timed out waiting for a message!"
end

IO.puts "\n=====================================\n"

# So now we are going to make module
# that will continue to take messages and not
# exit after just 1.
defmodule Greeter3 do
  def greet do
    receive do
      { sender, msg } ->
        send sender, { :ok, "Your message: #{msg} "}
      greet
    end
  end
end

pid = spawn(Greeter3, :greet, [])

send pid, { self, "Greeter3 in the house!" }

receive do
  { :ok, msg } ->
    IO.puts msg
end

send pid, { self, "Another One" }

receive do
  { :ok, msg } ->
    IO.puts msg
end
