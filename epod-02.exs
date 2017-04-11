require Bitwise

histo = fn d ->
        d
        |> Enum.reduce(%{zero: 0, one: 0, two: 0, three: 0, four: 0, five: 0, six: 0, seven: 0, eight: 0, nine: 0},
                fn d,m ->
                        case d - 48 do
                                0 -> Map.put(m, :zero, m[:zero] + 1)
                                1 -> Map.put(m, :one, m[:one] + 1)
                                2 -> Map.put(m, :two, m[:two] + 1)
                                3 -> Map.put(m, :three, m[:three] + 1)
                                4 -> Map.put(m, :four, m[:four] + 1)
                                5 -> Map.put(m, :five, m[:five] + 1)
                                6 -> Map.put(m, :six, m[:six] + 1)
                                7 -> Map.put(m, :seven, m[:seven] + 1)
                                8 -> Map.put(m, :eight, m[:eight] + 1)
                                9 -> Map.put(m, :nine, m[:nine] + 1)
                        end
                end)
end

largess = fn n ->
        nl = Bitwise.bsl(0b1,Bitwise.bsl(0b1,n)) |> Integer.to_charlist
        h = histo.(nl)

        tot = Map.keys(h)
        |> Enum.reduce(0, fn k,a -> a + h[k] end)

        Map.keys(h)
        |> Enum.reduce({h,tot}, fn k,a ->
                {m, t} = a
                {Map.put(m, k, round(m[k]/tot*10000)/100), t}
        end)
end

cond do
        length(System.argv) == 0 ->
                IO.puts "Specify a list of one or more numbers"
        System.argv ->
                System.argv
                |> Enum.each(fn sn ->
                        {r,_} = largess.(String.to_integer(sn))
                        IO.puts sn <> ": " <> "#{inspect r}"
                end)
end
