-- Textadept configs
textadept.editing.autocomplete_all_words = true
textadept.editing.strip_trailing_spaces = true
textadept.session.save_on_quit = false
textadept.editing.auto_pairs = nil
textadept.editing.typeover_chars = nil

-- Themes
if CURSES then
  ui.set_theme('light-term')
else
  ui.set_theme('light')
end

-- No Arg Invoke Opens 'a.txt', Removes It If Not Modified
events.connect(events.ARG_NONE, function()
  io.open_file(lfs.abspath('a.txt', os.getenv("PWD")))
end)

events.connect(events.FILE_OPENED, function()
  if #_BUFFERS == 1 then return end

  local atxt_buffer = nil
  for k, buf in ipairs(_BUFFERS) do
    local f = buf.filename and buf.filename:match('[^/]+$')
    if f == 'a.txt' then
      atxt_buffer = buf
    end
  end

  if not atxt_buffer then return end

  if not atxt_buffer.modify and atxt_buffer.text_length == 0 then
    atxt_buffer:delete()
  end
end)

-- Vim+overrides
tavi = require('textadept-vi')
keys.normal['U'] = buffer.redo
keys['cw'] = function () buffer:del_word_left() end
keys.lua_command['cw'] = function () ui.command_entry:del_word_left() end

---- Turbo Nav
keys.normal['H'] = function () tavi.move.character_left(5) tavi.set_line_offset() end
keys.normal['J'] = function () tavi.move.line_down(5) end
keys.normal['K'] = function () tavi.move.line_up(5) end
keys.normal['L'] = function () tavi.move.character_right(5) tavi.set_line_offset() end

keys.visual['H'] = function () tavi.select.character_left(5) tavi.set_line_offset() end
keys.visual['J'] = function () tavi.select.line_down(5) end
keys.visual['K'] = function () tavi.select.line_up(5) end
keys.visual['L'] = function () tavi.select.character_right(5) tavi.set_line_offset() end

keys.visual_line['H'] = function () tavi.select_line.character_left(5) end
keys.visual_line['J'] = function () tavi.select_line.line_down(5) end
keys.visual_line['K'] = function () tavi.select_line.line_up(5) end
keys.visual_line['L'] = function () tavi.select_line.character_right(5) end

keys.visual_block['H'] = function () tavi.select_block.character_left(5) tavi.set_line_offset() end
keys.visual_block['J'] = function () tavi.select_block.line_down(5) end
keys.visual_block['K'] = function () tavi.select_block.line_up(5) end
keys.visual_block['L'] = function () tavi.select_block.character_right(5) tavi.set_line_offset() end

-- Quit/Save
keys.normal['cs'] = io.save_file
keys.normal['cq'] = quit
keys['cs'] = function () io.save_file() tavi.enter_mode('normal') end

-- Exit to normal mode
-- Remap c; to c_ via terminal.
keys.find_incremental[CURSES and 'c_' or 'c;'] = function ()
  ui.find.find_entry_text = ui.command_entry:get_text()
  ui.command_entry.enter_mode()
  tavi.enter_mode('visual')
  tavi.select.character_left()
end

keys.find_incremental['\n'] = function ()
  ui.find.find_entry_text = ui.command_entry:get_text()
  ui.command_entry.enter_mode()
  tavi.enter_mode('normal')
end

local exit_command_modes = { 'lua_command', 'filter_through' }
for _, k in ipairs(exit_command_modes) do
  keys[k][CURSES and 'c_' or 'c;'] = function ()
    ui.command_entry.enter_mode(nil)
    tavi.enter_mode('normal')
  end
end

keys[CURSES and 'c_' or 'c;'] = function ()
  if buffer._textredux then
    io.close_buffer()
  end
  tavi.enter_mode('normal')
end

keys.visual[CURSES and 'c_' or 'c;'] = function () tavi.enter_mode('normal') end
keys.visual_block[CURSES and 'c_' or 'c;'] = function () tavi.enter_mode('normal') end
keys.visual_line[CURSES and 'c_' or 'c;'] = function () tavi.enter_mode('normal') end
keys.paste[CURSES and 'c_' or 'c;'] = function () tavi.exit_mode('paste') end

-- Autocomplete
-- Filename Completion
textadept.editing.autocompleters.filename = function ()
  local list = {}
  local line, pos = buffer:get_cur_line()
  -- filenames start after ', "; may start with ~, /; contain %w, _, ., -
  local part = line:sub(1, pos):match('[\'"]?([~/$]?[%w_%./-]+)$')
  if not part or part == '' then return nil end
  local home = os.getenv('HOME')
  if not home and part:match('~') then return nil end
  part = part:gsub('~', home)
  local lastslash = string.find(string.reverse(part), '/')
  local dir = lastslash and part:sub(1, #part - lastslash + 1) or part
  if lfs.attributes(dir, 'mode') == 'directory' then
    lfs.dir_foreach(dir, function(file)
      file = file:gsub('/(/*)', '/')  -- remove repeated /'s
      -- no support for filenames with spaces due to conflict with auto_c_separator
      if file:find(part, 1, true) == 1 and not file:match(' ') then
        file = file:gsub(home, '~')
        list[#list + 1] = file
      end
    end, nil, 0, true)
  end
  part = part:gsub(home, '~')
  return #part, list
end

-- Mapped from cspace in terminal.
keys[CURSES and 'c@' or 'c '] = function () textadept.editing.autocomplete('word') end
-- Mapped from cReturn in terminal.
keys[CURSES and 'c\\' or 'c\n'] = function () textadept.editing.autocomplete(buffer:get_lexer(true)) end
keys['cx'] = {}
keys['cx']['cf'] = function ()
  if buffer:auto_c_active() then
    buffer:auto_c_complete()
    textadept.editing.autocomplete('filename')
  else
    textadept.editing.autocomplete('filename')
  end
end

---- cn/cp in lua_command mode
keys.lua_command['cn'] = function () ui.command_entry:line_down() end
keys.lua_command['cp'] = function () ui.command_entry:line_up() end

-- Comment
if not keys.normal['g'] then keys.normal['g'] = {} end
keys.normal['g']['n'] = function () textadept.editing.block_comment() end
keys.visual['g']['n'] = function () textadept.editing.block_comment() end
keys.visual_line['g']['n'] = function () textadept.editing.block_comment() end

 --Buffer navigation
keys.normal['cw'] = {}
keys.normal['cw']['cn'] = function () view:goto_buffer(1) end
keys.normal['cw']['cp'] = function () view:goto_buffer(-1) end
keys.normal['cw']['n'] = function () view:goto_buffer(1) end
keys.normal['cw']['p'] = function () view:goto_buffer(-1) end

-- View Navigation
-- https://foicica.com/wiki/close-unsplit-view
keys.normal['cw']['q'] = function ()
  io.close_buffer()
  ui.goto_view(-1)
  view:unsplit()
end
keys.normal['cw']['c'] = keys.normal['cw']['q']
keys.normal['cw']['w'] = function () ui.goto_view(1) end
keys.normal['cw']['cw'] = function () ui.goto_view(-1) end
keys.normal['cw']['s'] = function () view:split() end
keys.normal['cw']['v'] = function () view:split(true) end

-- Text Redux
local textredux = require('textredux')
keys.normal['cp'] = function ()
  local dir = io.get_project_root() or buffer.filename:match('^(.+)[/\\]') or _HOME
  textredux.fs.snapopen(dir)
end
keys.normal['co'] = textredux.buffer_list.show
keys.normal['cg'] = textredux.ctags.goto_symbol

-- textadept-slime
tasl = require('textadept-slime')
keys.normal['cc'] = {}
keys.normal['cc']['cc'] = function ()
  local f = tasl.paste[buffer:get_lexer(true)]
  if f then f() else tasl.paste.text() end
end
keys.visual['cc'] = {}
keys.visual['cc']['cc'] = function ()
  local f = tasl.paste[buffer:get_lexer(true)]
  if f then tavi.adjust_act(f) else tavi.adjust_act(function () tasl.paste.text() end) end
end
keys.visual_line['cc'] = {}
keys.visual_line['cc']['cc'] = keys.visual['cc']['cc']

-- textadept-todo
events.connect(events.FILE_OPENED, function()
  local fname = buffer.filename and buffer.filename:match('[^/]+$')
  if fname and fname == 'todo.txt' then
    buffer:set_lexer('todo')
  end
end)

-- Makefiles
events.connect(events.LEXER_LOADED, function(lexer)
  if lexer == 'makefile' then
    buffer.use_tabs = true
    buffer.view_ws = buffer.WS_VISIBLEONLYININDENT
  end
end)

-- Calculator
-- https://foicica.com/wiki/bcmath
function replaceMath()
  local text = buffer:get_sel_text()
  local p = io.popen('echo "'..text..'" | bc 2>&1')
  local out = p:read('*all')
  p:close()
  buffer:replace_sel(out:gsub("\n", ""))
end

if not keys.visual['g'] then keys.visual['g'] = {} end
keys.visual['g']['c'] = function () tavi.adjust_act(replaceMath) end
if not keys.visual_line['g'] then keys.visual_line['g'] = {} end
keys.visual_line['g']['c'] = function () tavi.adjust_act(replaceMath) end
