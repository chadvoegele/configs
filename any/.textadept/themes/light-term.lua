-- Copyright 2007-2017 Mitchell mitchell.att.foicica.com. See LICENSE.
-- Terminal theme for Textadept.
-- Contributions by Ana Balan.

local buffer = buffer
local property, property_int = buffer.property, buffer.property_int

-- Normal colors.
property['color.black'] = 0x000000
property['color.red'] = 0x000080
property['color.green'] = 0x008000
property['color.yellow'] = 0x008080
property['color.blue'] = 0x800000
property['color.magenta'] = 0x800080
property['color.cyan'] = 0x808000
property['color.white'] = 0xBDBDBD

-- Light colors. (16 color terminals only.)
-- These only apply to 16 color terminals. For other terminals, set the
-- style's `bold` attribute to use the light color variant.
property['color.light_black'] = 0x404040
property['color.light_red'] = 0x0000FF
property['color.light_green'] = 0x00FF00
property['color.light_yellow'] = 0x00FFFF
property['color.light_blue'] = 0xFF0000
property['color.light_magenta'] = 0xFF00FF
property['color.light_cyan'] = 0xFFFF00
property['color.light_white'] = 0xFFFFFF

-- Predefined styles.
property['style.default'] = 'fore:$(color.black),back:$(color.white)'
property['style.linenumber'] = 'fore:$(color.black),back:$(color.white)'
property['style.bracelight'] = 'fore:$(color.black),back:$(color.green)'
--property['style.controlchar'] =
--property['style.indentguide'] =
property['style.calltip'] = '$(style.default)'
property['style.folddisplaytext'] = 'fore:$(color.white),bold'

-- Token styles.
property['style.class'] = 'fore:$(color.yellow)'
property['style.comment'] = 'fore:$(color.light_black)'
property['style.constant'] = 'fore:$(color.red)'
property['style.embedded'] = '$(style.keyword),back:$(color.white)'
property['style.error'] = 'fore:$(color.red),bold'
property['style.function'] = 'fore:$(color.blue)'
property['style.identifier'] = ''
property['style.keyword'] = 'fore:$(color.black),bold'
property['style.label'] = 'fore:$(color.red),bold'
property['style.number'] = 'fore:$(color.cyan)'
property['style.operator'] = 'fore:$(color.yellow)'
property['style.preprocessor'] = 'fore:$(color.magenta)'
property['style.regex'] = 'fore:$(color.green),bold'
property['style.string'] = 'fore:$(color.red)'
property['style.type'] = 'fore:$(color.magenta),bold'
property['style.variable'] = 'fore:$(color.blue)'
property['style.whitespace'] = ''

-- Multiple Selection and Virtual Space
buffer.additional_sel_fore = property['color.white']
buffer.additional_sel_back = property['color.black']
buffer.additional_caret_fore = property['color.light_black']

-- Caret and Selection Styles.
buffer:set_sel_fore(true, property['color.white'])
buffer:set_sel_back(true, property['color.black'])
buffer.caret_fore = property['color.light_black']
--buffer.caret_line_back =

-- Fold Margin.
--buffer:set_fold_margin_colour(true, property_int['color.white'])
--buffer:set_fold_margin_hi_colour(true, property_int['color.white'])

-- Markers.
local MARK_BOOKMARK = textadept.bookmarks.MARK_BOOKMARK
buffer.marker_back[MARK_BOOKMARK] = property_int['color.blue']
buffer.marker_back[textadept.run.MARK_WARNING] = property_int['color.yellow']
buffer.marker_back[textadept.run.MARK_ERROR] = property_int['color.red']

-- Indicators.
buffer.indic_fore[ui.find.INDIC_FIND] = property_int['color.yellow']
local INDIC_HIGHLIGHT = textadept.editing.INDIC_HIGHLIGHT
buffer.indic_fore[INDIC_HIGHLIGHT] = property_int['color.yellow']
local INDIC_PLACEHOLDER = textadept.snippets.INDIC_PLACEHOLDER
buffer.indic_fore[INDIC_PLACEHOLDER] = property_int['color.magenta']

-- Call tips.
--buffer.call_tip_fore_hlt = property_int['color.blue']

-- Long Lines.
buffer.edge_colour = property_int['color.red']
