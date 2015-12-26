map = %{ "name" => "david", "age" => 27 }
IO.inspect map

new_map = Map.put(map, "email", "david@aol.com")
IO.inspect new_map

