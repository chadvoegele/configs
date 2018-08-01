-- Remove all textadept.keys key bindings but add back the good ones
for k, v in pairs(keys) do
  if k~= 'CLEAR' and type(v) ~= 'table' then
    keys[k] = nil
  end
end
keys.cf, keys.cb = buffer.char_right, buffer.char_left
keys.cn, keys.cp = buffer.line_down, buffer.line_up
keys.ca, keys.ce = buffer.vc_home, buffer.line_end
keys.ch = buffer.delete_back

-- Textadept configs
textadept.editing.autocomplete_all_words = true
textadept.editing.strip_trailing_spaces = true
textadept.session.save_on_quit = false
textadept.editing.auto_pairs = nil
textadept.editing.typeover_chars = nil

-- Themes
if CURSES then
  buffer:set_theme('light-term')
else
  buffer:set_theme('light')
end

buffer.margin_width_n[2] = not CURSES and 12 or 0
buffer.margin_mask_n[2] = buffer.MASK_FOLDERS
buffer.v_scroll_bar = false
buffer.wrap_mode = buffer.WRAP_WORD

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
keys['cw'] = function () tavi.cut.word_start() end
keys.lua_command['cw'] = function () ui.command_entry:del_word_left() end

---- Turbo Nav
keys.normal['H'] = function () tavi.move.character_left(5) tavi.set_caret_x() end
keys.normal['J'] = function () tavi.move.line_down(5) end
keys.normal['K'] = function () tavi.move.line_up(5) end
keys.normal['L'] = function () tavi.move.character_right(5) tavi.set_caret_x() end

keys.visual['H'] = function () tavi.select.character_left(5) tavi.set_caret_x() end
keys.visual['J'] = function () tavi.select.line_down(5) end
keys.visual['K'] = function () tavi.select.line_up(5) end
keys.visual['L'] = function () tavi.select.character_right(5) tavi.set_caret_x() end

keys.visual_line['H'] = function () tavi.select_line.character_left(5) end
keys.visual_line['J'] = function () tavi.select_line.line_down(5) end
keys.visual_line['K'] = function () tavi.select_line.line_up(5) end
keys.visual_line['L'] = function () tavi.select_line.character_right(5) end

keys.visual_block['H'] = function () tavi.select_block.character_left(5) tavi.set_caret_x() end
keys.visual_block['J'] = function () tavi.select_block.line_down(5) end
keys.visual_block['K'] = function () tavi.select_block.line_up(5) end
keys.visual_block['L'] = function () tavi.select_block.character_right(5) tavi.set_caret_x() end

-- Quit/Save
keys.normal['cs'] = io.save_file
keys.normal['cq'] = quit
keys['cs'] = function () io.save_file() tavi.enter_mode('normal') end

-- Exit to normal mode
keys.find_incremental[CURSES and 'c_' or 'c;'] = function ()
  ui.find.find_entry_text = ui.command_entry:get_text()
  ui.command_entry.enter_mode()
  tavi.enter_mode('normal')
end

-- Remap c; to c_ via terminal.
keys.find_incremental_reverse[CURSES and 'c_' or 'c;'] = keys.find_incremental[CURSES and 'c_' or 'c;']

local exit_command_modes = { 'lua_command', 'filter_through' }
for _, k in ipairs(exit_command_modes) do
  keys[k][CURSES and 'c_' or 'c;'] = function ()
    ui.command_entry.enter_mode(nil)
    tavi.enter_mode('normal')
  end
end

-- TODO: Propose keys.DEFAULT_MODE = 'normal' in TA
ui.command_entry.finish_mode = function (f)
  if ui.command_entry:auto_c_active() then return false end -- allow Enter to autocomplete
  ui.command_entry.enter_mode('normal') -- ui.command_entry.enter_mode(keys.DEFAULT_MODE)
  if f then f(ui.command_entry:get_text()) end
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
  local has_tilde = part:match('~')
  if not home and has_tilde then return nil end
  part = has_tilde and part:gsub('~', home) or part
  local lastslash = string.find(string.reverse(part), '/')
  local dir = lastslash and part:sub(1, #part - lastslash + 1) or part
  if lfs.attributes(dir, 'mode') == 'directory' then
    lfs.dir_foreach(dir, function(file)
      file = file:gsub('/(/*)', '/')  -- remove repeated /'s
      if file:find(part, 1, true) == 1 then
        file = has_tilde and file:gsub(home, '~') or file
        list[#list + 1] = file
      end
    end, nil, 0, true)
  end
  part = has_tilde and part:gsub(home, '~') or part
  return #part, list
end

-- Mapped from cspace in terminal.
keys['c '] = function () textadept.editing.autocomplete('word') end
-- Mapped from cReturn in terminal.
keys[CURSES and 'c\\' or 'c\n'] = function () textadept.editing.autocomplete(buffer:get_lexer(true)) end
keys['cx'] = {}
keys['cx']['cf'] = function ()
  local sep = buffer.auto_c_separator
  buffer.auto_c_separator = string.byte('\n')  -- support filenames with spaces
  if buffer:auto_c_active() then
    buffer:auto_c_complete()
    textadept.editing.autocomplete('filename')
  else
    textadept.editing.autocomplete('filename')
  end
  buffer.auto_c_separator = sep -- restore
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
local last_buffer = buffer
events.connect(events.BUFFER_BEFORE_SWITCH, function() last_buffer = buffer end)
keys.normal['cw']['w'] = function()
  if _BUFFERS[last_buffer] then
    view:goto_buffer(last_buffer)
  end
end
keys.normal['cw']['cw'] = keys.normal['cw']['w']
keys.normal['cw'][';'] = keys.normal['cw']['w']
keys.normal['cw'][CURSES and 'c_' or 'c;'] = keys.normal['cw']['w']

-- View Navigation
-- https://foicica.com/wiki/close-unsplit-view
keys.normal['cw']['q'] = function ()
  io.close_buffer()
  ui.goto_view(-1)
  view:unsplit()
end
keys.normal['cw']['c'] = keys.normal['cw']['q']
keys.normal['cw']['o'] = function () ui.goto_view(1) end
keys.normal['cw']['s'] = function () view:split() end
keys.normal['cw']['v'] = function () view:split(true) end

-- Text Redux
local textredux = require('textredux')
textredux.core.buffer.DEFAULT_MODE = 'normal'
local get_ignore_cache = {}
local get_ignore = function (dir)
  local fignore_path = dir..'/.gitignore'
  if get_ignore_cache[fignore_path] then return get_ignore_cache[fignore_path] end
  local fignore = io.open(fignore_path, 'r')
  if not fignore then return nil end
  local ignore = {}
  for line in fignore:lines() do table.insert(ignore, line) end
  fignore:close()
  get_ignore_cache[fignore_path] = ignore
  return ignore
end
local filterFn = function (dir, ignore, filename)
  filter = false
  for _, patt in pairs(ignore) do
    local trim_patt = patt:gsub('^%s+', ''):gsub('%s+$', '')
    if not trim_patt:match('^$') and not trim_patt:match('[*]') then
      filter = filter or string.find(filename, dir..'/'..trim_patt, 1, true) ~= nil
    end
  end
  return filter
end
keys.normal['cp'] = function ()
  local dir = io.get_project_root() or buffer.filename and buffer.filename:match('^(.+)[/\\]') or os.getenv('PWD') or _HOME
  local ignore = get_ignore(dir)
  if not ignore then
    textredux.fs.snapopen(dir)
    return
  end
  local f = function (filename) return filterFn(dir, ignore, filename) end
  textredux.fs.snapopen(dir, { f, folders = { f }})
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

-- Javascript
if not keys.normal['g'] then keys.normal['g'] = {} end
if not keys.normal['g']['j'] then keys.normal['g']['j'] = {} end
tajs = require('textadept-js')
keys.normal['g']['j']['c'] = function () io.save_file() tajs.check() end

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

-- Replace
s = function (regexp, replacement)
  return textadept.editing.filter_through('sed "s/'..regexp..'/'..replacement..'/g"')
end

-- Filter Through
ft = textadept.editing.filter_through

-- Toggle Line Numbers (actually toggle margins but line number is easier to remember)
toggle_line_numbers = function ()
  if buffer.margin_width_n[0] == 0 and buffer.margin_width_n[1] == 0 then
    buffer.margin_width_n[0] = 4
    buffer.margin_width_n[1] = 1
  else
    buffer.margin_width_n[0] = 0
    buffer.margin_width_n[1] = 0
  end
end

-- editorconfig
if pcall(require, 'editorconfig_core') then
  require('editorconfig')
else
  io.stderr:write('Failed to load editorconfig\n')
end
