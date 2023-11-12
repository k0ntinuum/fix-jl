using Random
using Printf
include("print.jl")
include("key.jl")
include("fix-encode.jl")



function demo()
    num_states = 7
    #alph = "O|23456789" #"O|" #"O|"
    alph = "O|@*"
    min_out_len = 1
    max_out_len = 3
    f = random_key(num_states, alph, min_out_len, max_out_len)
    print_key(f)
    for i in 1:10
        p = randstring(alph,rand(1:3))
        print(white(),"f ",red())
        @printf("%-10s", p)
        #c = encode(p,f,alph)
        c = encrypt(p,f,alph)
        print(white(), " = ",yellow())
        @printf("%-25s\n", c)
        #d = decode(c,f,alph)
        d = decrypt(c,f,alph)
        if p != d @printf("\nERROR\n") end
        #print("d = ",d,"\n")
    end
end