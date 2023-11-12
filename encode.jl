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
    f = deepcopy(q)
    f = reverse(f)
    c = reverse(c)
    c = encode(c,f,alph)
end

function decrypt(c,q,alph)
    f = deepcopy(q)
    f = reverse(f)
    d = decode(c,f,alph)
    d = reverse(d)
    f = deepcopy(q)
    d = decode(d,f,alph)
    d
end