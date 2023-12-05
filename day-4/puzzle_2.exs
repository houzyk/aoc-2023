{ :ok, file_content } = File.read("./day-4/input.json")
{ :ok, input } = Jason.decode(file_content)

defmodule Utils do
  def get_total_cards_r(wins_tally, card_nb, carry \\ [], sum \\ 1) do
    cond do
      wins_tally[card_nb] > 0 ->
        to_carry = (
          (String.to_integer(card_nb, 10) + 1)..((String.to_integer(card_nb, 10)) + wins_tally[card_nb])) |> Enum.map(&("#{&1}")
        ) |> Enum.concat(carry)
        get_total_cards_r(wins_tally, hd(to_carry), tl(to_carry) , sum + wins_tally[card_nb])

      length(carry) > 0 -> get_total_cards_r(wins_tally, hd(carry), tl(carry) , sum)

      true -> sum
    end
  end
end

puzzle_2 = fn (input) ->
  Enum.reduce(input, %{}, fn { card_nb, card_data }, tally ->
    String.split(card_data, "|") |> Enum.map(&(Regex.scan(~r/[0-9]+/, &1) |> List.flatten))
    |> then(fn [ winnin_nbs, posses_nbs ] -> Map.put(
        tally,
        String.replace(card_nb, ~r/[^0-9]+/, ""),
        length(posses_nbs) - length(posses_nbs -- winnin_nbs)
      )
    end)
  end
  ) |> then(&(
    Enum.reduce(&1, 0, fn { card_nb, _ }, sum -> sum + Utils.get_total_cards_r(&1, card_nb) end)
  ))
end

# test_input = %{
#   "Card 1" => "41 48 83 86 17 | 83 86  6 31 17  9 48 53",
#   "Card 2" => "13 32 20 16 61 | 61 30 68 82 17 32 24 19",
#   "Card 3" => " 1 21 53 59 44 | 69 82 63 72 16 21 14  1",
#   "Card 4" => "41 92 73 84 69 | 59 84 76 51 58  5 54 83",
#   "Card 5" => "87 83 26 28 32 | 88 30 70 12 93 22 82 36",
#   "Card 6" => "31 18 13 56 72 | 74 77 10 23 35 67 36 11",
# }

puzzle_2.(input) |> IO.puts()
