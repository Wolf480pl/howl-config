if (_G.wolf480 == nil) then
  _G.wolf480 = {}
end

wolf480.cursor = user_load("wolf480.cursor")
wolf480.util = user_load("wolf480.util")
wolf480.mode = user_load("wolf480.mode")
wolf480.search = user_load("wolf480.search")

wolf480.cursor.install()
wolf480.mode.install()

howl.config.indent = 4
howl.mode.configure("moonscript", {
    indent=2,
})
howl.mode.configure("latex", {
    indent=2,
})

howl.bindings.push({
    editor = {
        ctrl_f = 'buffer-search-selection-forward',
        ctrl_r = 'buffer-search-selection-backward',
    }
})
