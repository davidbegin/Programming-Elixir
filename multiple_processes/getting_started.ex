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

IO.puts "\n=====================================\n"

defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
      fn (_, send_to) ->
        spawn(Chain, :counter, [send_to])
      end

    # start the count by sending 0
    send last, 0

    # and wait for the result to come back to use
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  # This method takes how long the Chain will be
  # If then output the Result of timing Chain.create_processes with said number
  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

Chain.run(100000)

IO.puts "\n=====================================\n"

defmodule Link1 do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn(Link1, :sad_function, [])
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened as far as I am concered"
    end
  end
end

Link1.run

IO.puts "\n=====================================\n"

defmodule Link2 do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    spawn_link(Link2, :sad_function, [])
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened as far as I am concered"
    end
  end
end

Link2.run
