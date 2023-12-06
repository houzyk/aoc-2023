{ :ok, file_content } = File.read("./day-5/input.json")
{ :ok, input } = Jason.decode(file_content)

puzzle_1 = fn (input) ->
  Regex.scan(~r/[0-9]+/, input["seeds"])
  |> Enum.map(fn [seed] -> String.to_integer(seed, 10) end)
  |> Enum.reduce(
    :infinity, fn seed_nb, res ->
      [ "seed-to-soil",
        "soil-to-fertilizer",
        "fertilizer-to-water",
        "water-to-light",
        "light-to-temperature",
        "temperature-to-humidity",
        "humidity-to-location"
      ] |> Enum.reduce(
        seed_nb, fn map, loc ->
          input[map] |> Enum.reduce(%{}, fn cds, cds_dict ->
            [ dest, source, range ] = Regex.scan(~r/[0-9]+/, cds) |> Enum.map(fn [t] -> String.to_integer(t, 10) end)
            %{ [source, source + (range - 1)] => dest } |> Enum.concat(cds_dict)
            end
          )
          |> Enum.find_value(loc, fn { [source_strt, source_end], dest } ->
            if loc <= source_end and loc >= source_strt, do: dest + (loc - source_strt)
          end)
        end
      ) |> min(res)
    end
  )
end

# test_input = %{
#   "seeds" => "79 14 55 13",
#   "seed-to-soil" => [
#     "50 98 2",
#     "52 50 48",
#   ],
#   "soil-to-fertilizer"  => [
#     "0 15 37",
#     "37 52 2",
#     "39 0 15",
#   ],
#   "fertilizer-to-water" => [
#     "49 53 8",
#     "0 11 42",
#     "42 0 7",
#     "57 7 4",
#   ],
#   "water-to-light" => [
#     "88 18 7",
#     "18 25 70",
#   ],
#   "light-to-temperature" => [
#     "45 77 23",
#     "81 45 19",
#     "68 64 13",
#   ],
#   "temperature-to-humidity" => [
#     "0 69 1",
#     "1 0 69",
#   ],
#   "humidity-to-location" => [
#     "60 56 37",
#     "56 93 4",
#   ]
# }


puzzle_1.(input) |> IO.puts()
