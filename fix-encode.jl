function roll!(f,n)
    for j in 1:n
        temp = f[1][1]
        for i in 1:length(f)-1
            f[i][1] = f[i+1][1]
        end
        f[end][1] =  temp
    end
end


function encode(p,f,alph)
    c = ""
    s = 1
    next_state_name = f[s][1]
    while length(p) > 0
    	if f[s][1] == next_state_name
            index = findfirst(isequal(p[begin]),alph)
    		next_state_name = f[s][index+1]
    		c *= next_state_name
    		p = p[begin+1:end]
            f[s][2:end] = circshift(f[s][2:end], 1)
            #roll!(f,index+1)

    	end
    	s = mod1(s+1,length(f))
    end
    c
end
function decode(c,f,alph)
    p = ""
    s = 1
    next_state_name = f[1][1]
    while length(c) > 0
    	if f[s][1] == next_state_name
    		index  = findfirst(map(i -> startswith(c, f[s][i]), 2:length(f[s])))
    		#if index == nothing throw("failed to find prefix") end
    		p *= alph[index:index]
    		c = c[length(f[s][index+1])+1: end]
    		next_state_name = f[s][index+1]
            f[s][2:end] = circshift(f[s][2:end], 1)
            #roll!(f,index+1)
    	end
    	s = mod1(s+1, length(f))
    end
    p
end

function roll_by(s, alph, i)
    n = map(x -> findfirst(isequal(x), alph), collect(s))
    r = map(x -> mod1(x+i,length(alph)), n )
    join(map(x -> alph[x:x], r))
end

function roll_state(s,alph,i)
    map(x -> roll_by(x, alph,i),s)
end


function num_from_string(s,alph)
    map(x -> findfirst(isequal(x),alph ) - 1 ,collect(s))
end

function state_number(f, i, alph)
    parse(Int64, join(num_from_string(join(f[mod1(i, length(f))]), alph)), base = 2)
end



function encrypt(p,q,alph)
    f = deepcopy(q)
    c = encode(p,f,alph)
    #f = deepcopy(q)
    #c = reverse(c)
    #c = encode(c,f,alph)
    c
end

function decrypt(c,q,alph)
    f = deepcopy(q)
    d = decode(c,f,alph)
    #d = reverse(d)
    #f = deepcopy(q)
    #d = decode(d,f,alph)
    d
end