{ :ok, file_content } = File.read("./day-3/input.json")
{ :ok, input} = Jason.decode(file_content)

puzzle_1 = fn (input) when is_list(input) ->
  [ nb_pos_data, sym_pos_data ] = [ ~r/[0-9]+/, ~r/[^0-9,\.]/, ] |> Enum.map(
    fn reg -> input |> Enum.with_index |> Enum.reduce(
        [], fn { str, line }, data ->
          Regex.scan(reg, str, return: :index) |> Enum.map(
            fn [{ pos, strlen }] ->
              %{  pos:  pos,
                  txt: String.slice(str, pos..(pos + (strlen - 1))),
                  line: line,
                }
            end
          ) |> Enum.concat(data)
        end
      )
    end
  )

  nb_pos_data |> Enum.reduce(
    0, fn %{ line: nb_line, pos: nb_pos, txt: nb  }, sum ->
      sym_pos_data |> Enum.find(
        fn %{ line: sym_line, pos: sym_pos } ->
          ( sym_line === nb_line ||
            (!!(nb_line - 1) && sym_line === (nb_line - 1)) ||
            (!!(nb_line + 1) && sym_line === (nb_line + 1))
          ) &&
          (sym_pos <= (nb_pos +  String.length(nb)) && sym_pos >= (nb_pos - 1))
        end
      ) &&
      String.to_integer(nb, 10) + sum || sum
    end
  )
end

puzzle_1.(input) |> IO.puts
