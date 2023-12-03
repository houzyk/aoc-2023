{ :ok, file_content } = File.read("./day-1/input.json")
{ :ok, input } = Jason.decode(file_content)

puzzle_1 = fn input when is_list(input) ->
  Enum.reduce(
    input, 0, fn value, sum ->
      calc = Regex.scan ~r/[0-9]/, value
      sum + String.to_integer "#{List.first(calc)}#{List.last(calc)}", 10
    end
  )
end

puzzle_1.(input) |> IO.puts
