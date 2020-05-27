local util = {}

function util.findupvalue(func, name)
    local nups = debug.getinfo(func).nups
    for i = 1, nups do
        local k, v = debug.getupvalue(func, i)
        if k == name then
            return i
        end
    end
    return nil
end

function util.wrapupvalue(func, name, wrap)
    local uv, orig, new, _
    uv = util.findupvalue(func, name)

    _, orig = debug.getupvalue(func, uv)
    new = wrap(orig)
    debug.setupvalue(func, uv, new)

    return orig, new
end

function util.getupvalue_by_name(func, name)
    local nups = debug.getinfo(func).nups
    for i = 1, nups do
        local k, v = debug.getupvalue(func, i)
        if k == name then
            return v
        end
    end
    return nil
end

function util.setupvalue_by_name(func, name, nv)
    local nups = debug.getinfo(func).nups
    for i = 1, nups do
        local k, v = debug.getupvalue(func, i)
        if k == name then
            debug.setupvalue(func, i, nv)
            return v
        end
    end
    return nil
end

return util
