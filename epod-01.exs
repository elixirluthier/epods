g0 = fn i ->

        j = fn f,n when n > 0 and is_list(f) and length(f) > 0 -> elem(Enum.at(f, div(n-1,2)),rem(n-1,2)) end

        g1 = fn n ->
                f = Stream.iterate({1,1}, &({elem(&1,0) + elem(&1,1) , elem(&1,1)+ elem(&1,0)+ elem(&1,1) }))
                |> Enum.take(div(n,2)+1)
                j.(f,n)/j.(f,n-1)
        end


        g2 = fn n ->
                ph = (1 + :math.sqrt(5))/2
                pn = :math.pow(ph, n)
                round Float.floor ((pn -  (:math.pow(-1.0,n)/pn))/:math.sqrt(5.0))
        end

        g1.(i) - (g2.(i)/g2.(i-1))
end

IO.puts 2..200
|> Enum.reduce_while(0, fn n,_ ->
  if g0.(n) == 0.0, do: {:cont, n}, else: {:halt, n}
end)
