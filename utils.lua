local utils = {}

-- only two levels deep
function utils.clone(t)
    local clone = {}
    if type(t) == 'table' then
        for k, v in pairs(t) do
            if type(v) == 'table' then
                local innerClone = {}
                for innerk, innerv in pairs(v) do
                    innerClone[innerk] = innerv
                end

                clone[k] = innerClone
                --table.insert(clone, innerClone)
            else
                clone[k] = v
                --table.insert(clone, v) 
            end
        end

        return clone
    else
        return nil
    end
end

function utils.posEqual(p1, p2)
    return p1.x == p2.x and p1.y == p2.y
end

function utils.test()
    local a = {hello = "foo", hey = "bar"}
    local b = utils.clone(a)

    assert(a.hey == b.hey)
    assert(b.hello == a.hello)

    print("Tests passed!!!")
end

return utils
