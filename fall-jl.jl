using Printf
using Random

function random_word(k) 
	rand(1:n,k)
end

function random_words(k,l,L) 
	map(i -> rand(1:length(alph),rand(l:L)), collect(1:k))
end

function str_from_vec(v)
	join(map(i -> i > 0 ? alph[i:i] : "f" , v))
end


function print_word(w)
    print(str_from_vec(w),"\n")
    @printf("\n")
end

function print_words(w)
    for i in eachindex(w) print(str_from_vec(w[i]),"\n") end
    @printf("\n")
end



function print_key(f)
    for i in eachindex(f[1])
    	@printf("%-5s %-5s \n", str_from_vec(f[1][i]),str_from_vec(f[2][i]))
    end
end
    

function prefix(p,q) 
	length(q) < length(p) ? false : count(map(i -> p[i] == q[i], 1:length(p))) == length(p)
end

function is_prefix_code(w) 
	count(map(x -> prefix(w[x[1]], w[x[2]]), [(i,j) for i=1:length(w) for j=1:length(w) if  i != j])) == 0
end

function no_repeats(w) 
	count(map(x -> w[x[1]] == w[x[2]], [(i,j) for i=1:length(w) for j=1:length(w) if  i < j])) == 0
end

function random_prefix_code(k,l,L)
    for i in 1:1000
        w = random_words(k,l,L)
        if is_prefix_code(w) return w end
    end
    throw("failed to find prefix code")
end

function random_long_code(k,L)
    w = random_words(k, 2, L)
    while !no_repeats(w) w = random_words(k, 2, L) end
    w
end

function random_short_code(k)
	collect( map( i -> [i] , Random.randperm(n)[1:k] ))
end

function random_key()
	g = []
	h = []
	for i in 1:4
		l = rand(1:4) + 1
		append!(g, random_long_code(l-1,2))
		append!(g, [[-1]])
		append!(g, random_long_code(l-1,2))
		append!(g, [[-1]])
		append!(g,random_short_code(2))
		append!(h, random_prefix_code(l,1,3))
		append!(h, random_prefix_code(l,1,3))
		append!(h, random_prefix_code(2,1,3))
	end
	f = [g,h]
	f
end


function encode(p,f)
    c = Int64[]
    i = 1
    counter = 0
    while length(p) > 0 && counter < 500
    	if f[1][i] == [-1]
    		append!(c,f[2][i])
    	end	
    	if prefix(f[1][i], p)
    		append!(c,f[2][i])
    		p = p[length(f[2][i]):end]
    	end
    	i  = mod1(i + 1, length(f[1]))
    	counter += 1
    	print_word(c)
    end
	c
end

function decode(c,f)
    p = Int64[]
    i = 1
    counter = 0
    while length(c) > 0 && counter < 500
    	if prefix(f[2][i], c) 
    		c = c[length(f[1][i]):end]
    		append!(p,f[1][i])
    	end
    	i  = mod1(i + 1, length(f[1]))
    	counter += 1
    	print_word(p)
    end
	p
end


function demo()
	
	f = random_key() 
    print_key(f)
    for i in 1:1
        p = rand(1:2,10)
        c = encode(p,deepcopy(f))
        d = decode(c,deepcopy(f))
        print_word(p)
        print_word(c)
        print_word(d)
    end
end

alph = "O|"
n = 2
#demo()


		
	
