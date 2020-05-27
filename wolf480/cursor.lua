local thismod = {}

thismod.orig_word_left = howl.ui.Cursor.word_left
thismod.orig_word_right = howl.ui.Cursor.word_right

function thismod.new_word_left(self, extend)
    extend = extend or false
    local ctx = self.container.buffer:context_at(self.pos)
    if (ctx.prefix.is_blank and self.column_index ~= 1) then
        local pos = self._line.start_pos
        self.cursor:move_to({pos = pos, extend = extend})
    else
        thismod.orig_word_left(self, extend)
    end
end

function thismod.new_word_right(self, extend)
    extend = extend or false
    if (self.at_end_of_line and not self.at_end_of_file) then
        self:move_to({line=self.line+1, extend=extend})
    else
        thismod.orig_word_right(self, extend)
    end
end

function thismod.install()
    howl.ui.Cursor.__base.word_left = thismod.new_word_left
    howl.ui.Cursor.__base.word_right = thismod.new_word_right
end

return thismod
