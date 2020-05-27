local app = howl.app

local function search_handler(commit)
    if (commit) then
        app.editor.searcher:commit()
    end
end

local search_fw = {
    name="buffer-search-selection-forward",
    description="Start an interactive forward search of the current selection",
    handler=search_handler,
}

local search_bw = {
    name="buffer-search-selection-backward",
    description="Start an interactive backward search of the current selection",
    handler=search_handler,
}

function search_fw.input()
    local sel = app.editor.selection.text
    if (sel) then
        app.window.command_line:write_spillover(sel)
    end
    if (howl.interact.forward_search()) then
        return true
    end
    app.editor.searcher:cancel()
end

function search_bw.input()
    local sel = app.editor.selection.text
    if (sel) then
        app.window.command_line:write_spillover(sel)
    end
    if (howl.interact.backward_search()) then
        return true
    end
    app.editor.searcher:cancel()
end

howl.command.register(search_fw)
howl.command.register(search_bw)
