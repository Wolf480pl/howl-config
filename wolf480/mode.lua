local thismod = {
    orig_instance_for_node = nil,
    new_instance_for_mode = nil,
}

local util = user_load('wolf480.util')

function thismod.wrap_instance_for_mode(orig)
    local function wrapper(m)
        local instance = orig(m)
        return setmetatable({},{
            __index = function(self, key)
                if key == 'word_pattern' then
                    return instance.config.word_pattern or
                                instance.word_pattern
                end
                return instance[key]
            end,
        })
    end
    return wrapper
end

thismod.word_pattern_config = {
    name = 'word_pattern',
    description = "Override of the regex pattern used for deciding what is a word",
    validate = function(v)
        if v == nil then
            return true
        end
        local ok, err = pcall(r, v)
        return ok
    end,
    type_of = 'string',
}

function thismod.install()
    howl.config.define(thismod.word_pattern_config)
    local orig, new = util.wrapupvalue(
            howl.mode.for_file,
            'instance_for_mode',
            thismod.wrap_instance_for_mode)
    thismod.orig_instance_for_mode = orig
    thismod.new_instance_for_mode = new
end

return thismod
