{ :ok, file_content } = File.read("./day-4/input.json")
{ :ok, input } = Jason.decode(file_content)

puzzle_1 = fn (input) -> input |> Enum.reduce(
  0, fn { _, card_data }, sum ->
      [
        winnin_nbs,
        posses_nbs
      ] = String.split(card_data, "|")
          |> Enum.map(&(Regex.scan(~r/[0-9]+/, &1) |> List.flatten))
      sum + (
        (length(posses_nbs) - length(posses_nbs -- winnin_nbs)) - 1
        |> then(&(:math.pow(2, &1) |> :math.floor |> round))
      )
    end
  )
end

# test_input = %{
#   "Card 1" => "41 48 83 86 17 | 83 86  6 31 17  9 48 53",
#   "Card 2" => "13 32 20 16 61 | 61 30 68 82 17 32 24 19",
#   "Card 3" => " 1 21 53 59 44 | 69 82 63 72 16 21 14  1",
#   "Card 4" => "41 92 73 84 69 | 59 84 76 51 58  5 54 83",
#   "Card 5" => "87 83 26 28 32 | 88 30 70 12 93 22 82 36",
#   "Card 6" => "31 18 13 56 72 | 74 77 10 23 35 67 36 11",
# }

puzzle_1.(input) |> IO.puts()
