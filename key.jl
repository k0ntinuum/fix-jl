function random_words(num_words, alph, min_len, max_len )
    map(i -> randstring(alph, rand(min_len:max_len)), collect(1:num_words))
end

function is_prefix_code(w) 
	count(map(x -> startswith(w[x[1]], w[x[2]]), [(i,j) for i=1:length(w) for j=1:length(w) if  i != j])) == 0
end

function random_prefix_code(num_words, alph, min_len, max_len)
    for i in 1:1000
        w = random_words(num_words, alph, min_len, max_len)
        if is_prefix_code(w) return w end
    end
    throw("failed to find prefix code")
end

function random_state(states, alph)
    subset = randperm(length(states))[1:length(alph)]
    map(i -> states[i], subset)
end

function random_key(num_states, alph, min_len, max_len)
    states = random_prefix_code(num_states, alph, min_len, max_len)
    f = []
    for i in eachindex(states)
        push!(f, append!([states[i]], random_state(states, alph)))
    end
    f 
end