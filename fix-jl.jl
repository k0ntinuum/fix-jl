using Random
using Printf
include("print.jl")
include("key.jl")
include("fix-encode.jl")



function demo()
    num_states = 21
    #alph = "O|23456789" #"O|" #"O|"
    alph = "O|"
    min_out_len = 5
    max_out_len = 7
    f = random_key(num_states, alph, min_out_len, max_out_len)
    q = deepcopy(f)
    
    print_key(f)
    for i in 1:20
        p = randstring(alph,rand(1:3))
        print(white(),"f ",red())
        @printf("%-10s", p)
        #c = encode(p,f,alph)
        c = encrypt(p,f,alph)
        print(white(), " = ",yellow())
        @printf("%-25s\n", c)
        #f = deepcopy(q)
        #d = decode(c,f,alph)
        d = decrypt(c,f,alph)
        if p != d @printf("\nERROR\n") end
        #print("d = ",d,"\n")
    end
end