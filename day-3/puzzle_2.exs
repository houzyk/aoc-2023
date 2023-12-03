{ :ok, file_content } = File.read("./day-3/input.json")
{ :ok, input} = Jason.decode(file_content)

puzzle_2 = fn (input) when is_list(input) ->
  [ nb_pos_data, sym_pos_data ] = [ ~r/[0-9]+/, ~r/[^0-9,\.]/, ] |> Enum.map(
    fn reg -> input |> Enum.with_index |> Enum.reduce(
        [], fn { str, line }, data ->
          Regex.scan(reg, str, return: :index) |> Enum.map(
            fn [{ pos, strlen }] ->
              %{  pos:  pos,
                  txt:  String.slice(str, pos..(pos + (strlen - 1))),
                  line: line,
                }
            end
          ) |> Enum.concat(data)
        end
      )
    end
  )

  sym_pos_data |> Enum.reduce(
    0, fn %{ line: sym_line, pos: sym_pos, }, sum ->
      nbs_near = nb_pos_data |> Enum.filter(
        fn %{ line: nb_line, pos: nb_pos, txt: nb } ->
          ( sym_line === nb_line ||
            (!!(nb_line - 1) && sym_line === (nb_line - 1)) ||
            (!!(nb_line + 1) && sym_line === (nb_line + 1))
          ) &&
          (sym_pos <= (nb_pos +  String.length(nb)) && sym_pos >= (nb_pos - 1))
        end
      ) |> Enum.map(&(String.to_integer(&1[:txt], 10)))
      length(nbs_near) === 2 && Enum.reduce(nbs_near, 1, &(&1 * &2)) + sum || sum
    end
  )
end

puzzle_2.(input) |> IO.puts
