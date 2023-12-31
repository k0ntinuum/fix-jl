function str_from_vec(v,s)
    join(map(i -> s.out_alph[i:i] * s,v ))
end

function rgb(r,g,b)
    "\e[38;2;$(r);$(g);$(b)m"
end

function red()
    rgb(255,0,0)
end

function yellow()
    rgb(255,255,0)
end

function white()
    rgb(255,255,255)
end

function gray(h)
    rgb(h,h,h)
end

function print_state(s)
    #print(red())
    for i in eachindex(s)
        @printf("%-12s ", s[i])
    end
    @printf("\n")
end

function print_key(f)
    for i in eachindex(f)
        print_state(f[i])
        #if i % 10 == 0 println() end
    end
    println()
end