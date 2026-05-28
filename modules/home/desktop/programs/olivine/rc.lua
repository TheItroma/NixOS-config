-- MUST BE THE FIRST LINE!!!
local STARTUP_MS = olv_uptime_ms()

-- Standard library imports.
local olvstd = {
	keyboard = require("olvstd.keyboard"),
	object = require("olvstd.object"),
	wm = require("olvstd.wm"),
}

-- Initialize the window manager.
-- This is required in order for it to work later.
olvstd.wm.init()

local IOTA = 0
local function iota(x)
	if x ~= nil then
		IOTA = x
	end

	local at = IOTA

	IOTA = IOTA + 1

	return at
end

local CONSOLE_WINDOW_DEPTH = iota(4096)
local LIST_PROMPT_WINDOW_DEPTH = iota()

local CONSOLE_WINDOW = nil
local CONSOLE_WINDOW_FOCUS_GIVE_BACK = 0

-- Toggle console window.
local function toggle_console_window()
	if CONSOLE_WINDOW == nil then
		CONSOLE_WINDOW = olvstd.object.Window:new()
		CONSOLE_WINDOW_FOCUS_GIVE_BACK = olv_window_get_active()
		if CONSOLE_WINDOW ~= nil then
			olvstd.wm.set_floating(CONSOLE_WINDOW.id, true)

			local buffer = olvstd.object.Buffer:wrap(OLV_SBID_CONSOLE)
			CONSOLE_WINDOW:set_buffer_object(buffer)
			CONSOLE_WINDOW:set_depth(CONSOLE_WINDOW_DEPTH)
			CONSOLE_WINDOW:set_attributes(OLV_WINATTR_NO_VOID_LINE_MARKERS)
		end
	else
		CONSOLE_WINDOW:delete()
		CONSOLE_WINDOW = nil
		olvstd.object.Window:wrap(CONSOLE_WINDOW_FOCUS_GIVE_BACK):focus()
	end
end

-- Show console window.
local function show_console_window()
	if CONSOLE_WINDOW == nil then
		toggle_console_window()
	end
end

local MODELINE_WINDOW = nil
local MODELINE_BUFFER = nil
local MODELINE_TEXT = "<< MODELINE >>"
local MODELINE_MESSAGE = ""
local MODELINE_DIRTY = true

-- Set modeline text.
local function modeline_set(text)
	if MODELINE_TEXT == text then
		return nil
	end

	MODELINE_TEXT = text
	MODELINE_DIRTY = true
end

-- Set message text.
local function message(text)
	if MODELINE_MESSAGE == text then
		return nil
	end

	MODELINE_MESSAGE = text
	MODELINE_DIRTY = true
end

-- Set message text and log it in the console.
local function message_console(text)
	message(text)
	olv_println(text)
end

local COMMAND_RESTORE = {}

local _, COMMAND_KEYMAP = olv_keymap_create()

local function command_begin(prefix)
	COMMAND_RESTORE.focused_window = olv_window_get_active()
	COMMAND_RESTORE.focused_keymap = olv_keymap_focused()

	olv_keymap_focus(COMMAND_KEYMAP)

	MODELINE_BUFFER:clear()
	MODELINE_WINDOW:set_buffer_object(MODELINE_BUFFER) -- Quick hack to trigger Olivine's internal cursor check.
	MODELINE_WINDOW:focus()
	MODELINE_BUFFER:clear_highlights()
	if prefix ~= nil then
		MODELINE_WINDOW:type_text(prefix)
	end
	olv_mode_set(OLV_MODE_INSERT)
end

local function command_end(perform)
	olvstd.object.Window:wrap(COMMAND_RESTORE.focused_window):focus()
	olv_keymap_focus(COMMAND_RESTORE.focused_keymap)

	olv_mode_set(OLV_MODE_NORMAL)

	MODELINE_DIRTY = true

	if perform then
		local text = MODELINE_BUFFER:text()

		local runtime = olvstd.object.Runtime:new()
		if runtime ~= nil then
			runtime:dispatch_string(text)
			runtime:block()
			runtime:delete()
		end
	else
		message("-- COMMAND CANCELLED --")
	end
end

local function command_backspace()
	MODELINE_WINDOW:type_text("\b")
end

local function command_direction(direction)
	if direction == OLV_DIRECTION_LEFT or direction == OLV_DIRECTION_RIGHT then
		MODELINE_WINDOW:move_cursors(direction)
	end
end

-- COMMAND KEYBINDS START
olvstd.keyboard.register_keybinds({
	{
		keymap = COMMAND_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_ESCAPE,
		dispatch = function()
			command_end(false)
		end,
	},
	{
		keymap = COMMAND_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_ENTER,
		dispatch = function()
			command_end(true)
		end,
	},
	{
		keymap = COMMAND_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_BACKSPACE,
		dispatch = function()
			command_backspace()
		end,
	},
	{
		keymap = COMMAND_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_UP,
		dispatch = function()
			command_direction(OLV_DIRECTION_UP)
		end,
	},
	{
		keymap = COMMAND_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_DOWN,
		dispatch = function()
			command_direction(OLV_DIRECTION_DOWN)
		end,
	},
	{
		keymap = COMMAND_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_LEFT,
		dispatch = function()
			command_direction(OLV_DIRECTION_LEFT)
		end,
	},
	{
		keymap = COMMAND_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_RIGHT,
		dispatch = function()
			command_direction(OLV_DIRECTION_RIGHT)
		end,
	},
})
-- COMMAND KEYBINDS END

local LIST_PROMPT_WINDOW = nil
local LIST_PROMPT_BUFFER = nil
local LIST_PROMPT_INDEX = 1
local LIST_PROMPT_ITEMS = nil
local LIST_PROMPT_DIRTY = true

local LIST_PROMPT_RESTORE = {}

local _, LIST_PROMPT_KEYMAP = olv_keymap_create()

local function list_prompt(items)
	LIST_PROMPT_RESTORE.focused_window = olv_window_get_active()
	LIST_PROMPT_RESTORE.focused_keymap = olv_keymap_focused()

	olv_keymap_focus(LIST_PROMPT_KEYMAP)

	if LIST_PROMPT_BUFFER == nil then
		LIST_PROMPT_BUFFER = olvstd.object.Buffer:new()
	end

	if LIST_PROMPT_WINDOW == nil then
		LIST_PROMPT_WINDOW = olvstd.object.Window:new()
	end

	LIST_PROMPT_WINDOW:focus()
	LIST_PROMPT_BUFFER:clear()
	LIST_PROMPT_WINDOW:set_depth(LIST_PROMPT_WINDOW_DEPTH)
	LIST_PROMPT_WINDOW:set_buffer_object(LIST_PROMPT_BUFFER)
	LIST_PROMPT_WINDOW:set_attributes(
		OLV_WINATTR_NO_VOID_LINE_MARKERS
			| OLV_WINATTR_INVISIBLE_CURSORS
			| OLV_WINATTR_NO_AUTO_SCROLL
			| OLV_WINATTR_UNLISTED
	)
	olvstd.wm.set_floating(LIST_PROMPT_WINDOW.id, true)

	LIST_PROMPT_ITEMS = items

	LIST_PROMPT_INDEX = 1

	LIST_PROMPT_DIRTY = true
end

local function list_prompt_end(perform)
	olvstd.object.Window:wrap(LIST_PROMPT_RESTORE.focused_window):focus()
	olv_keymap_focus(LIST_PROMPT_RESTORE.focused_keymap)

	LIST_PROMPT_WINDOW:delete()
	LIST_PROMPT_WINDOW = nil

	LIST_PROMPT_BUFFER:delete()
	LIST_PROMPT_BUFFER = nil

	if perform then
		if LIST_PROMPT_ITEMS[LIST_PROMPT_INDEX] ~= nil then
			LIST_PROMPT_ITEMS[LIST_PROMPT_INDEX].execute()
		end
	else
		message("-- LIST PROMPT CANCELLED --")
	end
end

local function update_list_prompt()
	if not LIST_PROMPT_DIRTY then
		return nil
	end

	if LIST_PROMPT_WINDOW == nil then
		return nil
	end

	if LIST_PROMPT_BUFFER == nil then
		return nil
	end

	LIST_PROMPT_BUFFER:clear()
	LIST_PROMPT_WINDOW:set_buffer_object(LIST_PROMPT_BUFFER) -- Hack that spawns cursors if they are missing.
	local needs_newline = false
	local i = 1
	for _, v in ipairs(LIST_PROMPT_ITEMS) do
		if needs_newline then
			LIST_PROMPT_WINDOW:type_text("\n")
		end
		if i == LIST_PROMPT_INDEX then
			for _ = 1, LIST_PROMPT_WINDOW:get_size().x do
				LIST_PROMPT_WINDOW:type_text(" ")
			end
			LIST_PROMPT_WINDOW:type_text("\r")
		end
		LIST_PROMPT_WINDOW:type_text(v.display)
		needs_newline = true

		i = i + 1
	end
	LIST_PROMPT_BUFFER:clear_highlights()
	LIST_PROMPT_BUFFER:add_highlight({
		span_start = { x = 0, y = LIST_PROMPT_INDEX - 1 },
		span_end = { x = 1024, y = LIST_PROMPT_INDEX - 1 },
		fg = 0,
		bg = 13,
	})

	LIST_PROMPT_DIRTY = false
end

local function list_prompt_direction(direction)
	if direction == OLV_DIRECTION_UP then
		if LIST_PROMPT_INDEX > 1 then
			LIST_PROMPT_INDEX = LIST_PROMPT_INDEX - 1
		else
			LIST_PROMPT_INDEX = #LIST_PROMPT_ITEMS
		end
		LIST_PROMPT_DIRTY = true
	elseif direction == OLV_DIRECTION_DOWN then
		if LIST_PROMPT_INDEX < #LIST_PROMPT_ITEMS then
			LIST_PROMPT_INDEX = LIST_PROMPT_INDEX + 1
		else
			LIST_PROMPT_INDEX = 1
		end
		LIST_PROMPT_DIRTY = true
	end
end

-- LIST PROMPT KEYBINDS START
olvstd.keyboard.register_keybinds({
	{
		keymap = LIST_PROMPT_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_ESCAPE,
		dispatch = function()
			list_prompt_end(false)
		end,
	},
	{
		keymap = LIST_PROMPT_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_ENTER,
		dispatch = function()
			list_prompt_end(true)
		end,
	},
	{
		keymap = LIST_PROMPT_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_UP,
		dispatch = function()
			list_prompt_direction(OLV_DIRECTION_UP)
		end,
	},
	{
		keymap = LIST_PROMPT_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_DOWN,
		dispatch = function()
			list_prompt_direction(OLV_DIRECTION_DOWN)
		end,
	},
	{
		keymap = LIST_PROMPT_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_LEFT,
		dispatch = function()
			list_prompt_direction(OLV_DIRECTION_LEFT)
		end,
	},
	{
		keymap = LIST_PROMPT_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_RIGHT,
		dispatch = function()
			list_prompt_direction(OLV_DIRECTION_RIGHT)
		end,
	},
})
-- LIST PROMPT KEYBINDS END

-- Get active window.
local function get_active_window()
	return olvstd.object.Window:wrap(olv_window_get_active())
end

-- Get active buffer.
local function get_active_buffer()
	local status, buffer_id = olv_window_get_buffer(olv_window_get_active())

	if status ~= OLV_STATUS_OK then
		olv_log_error("Failed to get active buffer: " .. olv_status_string(status))
		return nil
	end

	return olvstd.object.Buffer:wrap(buffer_id)
end

-- Type text into active window + buffer.
local function type_text(text)
	local window = get_active_window()

	if window == nil then
		return nil
	end

	window:type_text(text)
end

local function handle_direction(direction)
	local window = get_active_window()

	if window == nil then
		return nil
	end

	window:move_cursors(direction)
end

-- Enable cursor selection in active window.
local function selection_enable(enable)
	get_active_window():cursors_enable_selection(enable)
end

-- Delete cursor-selected text in active window + buffer.
local function seldel()
	get_active_window():cursors_seldel()
end

local function escape()
	olv_mode_set(OLV_MODE_NORMAL)
	olv_keymap_focus(OLV_DEFAULT_KEYMAP)
	selection_enable(false)
end

local function enter()
	if olv_mode_get() == OLV_MODE_INSERT then
		type_text("\n")
	else
		local window = olvstd.object.Window:new()
		window:focus()
	end
end

local function tab()
	if olv_mode_get() == OLV_MODE_INSERT then
		type_text("\t")
	end
end

local function backspace()
	if olv_mode_get() == OLV_MODE_INSERT then
		type_text("\b")
	end
end

local function buffer_list(include_hidden)
	local list = olv_buffer_list(include_hidden)

	local entries = {}

	for k, v in ipairs(list) do
		local vobj = olvstd.object.Buffer:wrap(v)
		local name = vobj:display_name()
		entries[k] = {
			display = name .. " (BID " .. v .. ")",
			execute = function()
				-- Basically, this just sets the buffer of the active window to the entry's pointed-to buffer.
				olvstd.object.Window:wrap(olv_window_get_active()):set_buffer_object(olvstd.object.Buffer:wrap(v))
			end,
		}
	end

	list_prompt(entries)
end

local function window_list(include_hidden)
	local list = olv_window_list(include_hidden)

	local entries = {}

	for k, v in ipairs(list) do
		entries[k] = {
			display = "Window (WID " .. v .. ")",
			execute = function()
				olv_window_set_active(v)
			end,
		}
	end

	list_prompt(entries)
end

local _, SPACE_KEYMAP = olv_keymap_create()
olv_keymap_handback_set(SPACE_KEYMAP, OLV_DEFAULT_KEYMAP) -- Hand control back to default keymap when key is pressed in this keymap.

-- KEYBINDS START
olvstd.keyboard.register_keybinds({
	{
		description = "The mighty escape key!",
		key = OLV_UI_BACKEND_KEYCODE_ESCAPE,
		dispatch = function()
			escape()
		end,
	},
	{
		description = "Quit editor.",
		key = "q",
		dispatch = function()
			show_console_window()
			olv_println("Closing...")
			olv_sleep_ms(500)
			olv_quit()
		end,
	},
	{
		description = "Toggle console window.",
		key = "C",
		dispatch = function()
			toggle_console_window()
		end,
	},
	{
		description = "Toggle console window.",
		key = OLV_UI_BACKEND_KEYCODE_ENTER,
		mod_keys = OLV_UI_BACKEND_MOD_CONTROL | OLV_UI_BACKEND_MOD_SHIFT,
		dispatch = function()
			toggle_console_window()
		end,
	},
	{
		description = "Activate space keymap.",
		key = " ",
		dispatch = function()
			olv_keymap_focus(SPACE_KEYMAP)
		end,
	},
	{
		description = "Exit space keymap.",
		keymap = SPACE_KEYMAP,
		key = OLV_UI_BACKEND_KEYCODE_ESCAPE,
		dispatch = function()
			olv_keymap_focus(OLV_DEFAULT_KEYMAP)
		end,
	},
	{
		description = "Open buffer list.",
		keymap = SPACE_KEYMAP,
		key = "b",
		dispatch = function()
			buffer_list(false)
		end,
	},
	{
		description = "Open buffer list (including hidden buffers).",
		keymap = SPACE_KEYMAP,
		key = "B",
		dispatch = function()
			buffer_list(true)
		end,
	},
	{
		description = "Open window list.",
		keymap = SPACE_KEYMAP,
		key = "w",
		dispatch = function()
			window_list(false)
		end,
	},
	{
		description = "Open window list (including hidden windows).",
		keymap = SPACE_KEYMAP,
		key = "W",
		dispatch = function()
			window_list(true)
		end,
	},
	{
		description = "Enter insert mode.",
		key = "i",
		dispatch = function()
			olv_mode_set(OLV_MODE_INSERT)
		end,
	},
	{
		description = "Enable selection mode.",
		key = "v",
		dispatch = function()
			selection_enable(true)
		end,
	},
	{
		description = "Disable selection mode.",
		key = "V",
		dispatch = function()
			selection_enable(false)
		end,
	},
	{
		description = "Delete text under selection.",
		key = OLV_UI_BACKEND_KEYCODE_DELETE,
		dispatch = function()
			seldel()
		end,
	},
	{
		description = "Delete text under selection.",
		key = "d",
		dispatch = function()
			seldel()
		end,
	},
	{
		-- This is a little hidden keybind.
		-- It is also to show that Olivine supports Unicode keybinds.
		key = "д",
		dispatch = function()
			olv_println("Сука блять!")
			list_prompt({
				{
					display = "Сука",
					execute = function()
						message("Сука блять (Сука)!")
					end,
				},
				{
					display = "Блять",
					execute = function()
						message("Сука блять (Блять)!")
					end,
				},
				{
					display = "Solarized",
					execute = function()
						-- Color Palette From: https://ethanschoonover.com/solarized/
						local color_palette = {
							BLACK = 0x002b36,
							BLACK_BRIGHT = 0x073642,
							RED = 0xdc322f,
							RED_BRIGHT = 0xdc322f,
							GREEN = 0x859900,
							GREEN_BRIGHT = 0x859900,
							YELLOW = 0xb58900,
							YELLOW_BRIGHT = 0xb58900,
							BLUE = 0x268bd2,
							BLUE_BRIGHT = 0x268bd2,
							MAGENTA = 0xd33682,
							MAGENTA_BRIGHT = 0xd33682,
							CYAN = 0x2aa198,
							CYAN_BRIGHT = 0x2aa198,
							WHITE = 0xeee8d5,
							WHITE_BRIGHT = 0xeee8d5,
						}

						for k, v in pairs(color_palette) do
							olv_ui_backend_hint("ANSI_COLOR_" .. k, v)
						end
					end,
				},
			})
		end,
	},
	{
		key = OLV_UI_BACKEND_KEYCODE_ENTER,
		dispatch = function()
			enter()
		end,
	},
	{
		key = OLV_UI_BACKEND_KEYCODE_TAB,
		dispatch = function()
			tab()
		end,
	},
	{
		key = OLV_UI_BACKEND_KEYCODE_BACKSPACE,
		dispatch = function()
			backspace()
		end,
	},
	{
		key = OLV_UI_BACKEND_KEYCODE_UP,
		dispatch = function()
			handle_direction(OLV_DIRECTION_UP)
		end,
	},
	{
		key = OLV_UI_BACKEND_KEYCODE_DOWN,
		dispatch = function()
			handle_direction(OLV_DIRECTION_DOWN)
		end,
	},
	{
		key = OLV_UI_BACKEND_KEYCODE_LEFT,
		dispatch = function()
			handle_direction(OLV_DIRECTION_LEFT)
		end,
	},
	{
		key = OLV_UI_BACKEND_KEYCODE_RIGHT,
		dispatch = function()
			handle_direction(OLV_DIRECTION_RIGHT)
		end,
	},
	{
		key = "k",
		dispatch = function()
			handle_direction(OLV_DIRECTION_UP)
		end,
	},
	{
		key = "j",
		dispatch = function()
			handle_direction(OLV_DIRECTION_DOWN)
		end,
	},
	{
		key = "h",
		dispatch = function()
			handle_direction(OLV_DIRECTION_LEFT)
		end,
	},
	{
		key = "l",
		dispatch = function()
			handle_direction(OLV_DIRECTION_RIGHT)
		end,
	},
	{
		description = "Execute Lua code.",
		key = "/",
		dispatch = function()
			command_begin()
		end,
	},
})
-- KEYBINDS END

-- Master-stack layout function.
local function layout_master_stack(context)
	local geom = {
		x = 0,
		y = 0,
		z = 0,
		w = 0,
		h = 0,
	}

	local ratio = 0.5

	local master_width = math.floor(context.area_size.x * ratio)

	if context.index == 1 then
		geom.x = 0
		geom.y = 0
		geom.w = master_width
		geom.h = context.area_size.y

		if context.count == 1 then
			geom.w = context.area_size.x
		end

		return geom
	end

	local stack_count = context.count - 1
	local stack_index = context.index - 1

	local stack_window_width = context.area_size.x - master_width
	local stack_window_height = math.floor(context.area_size.y / stack_count)

	local remainder = context.area_size.y % stack_count

	geom.x = master_width
	geom.y = stack_window_height * (stack_index - 1)

	geom.w = stack_window_width
	geom.h = stack_window_height

	if stack_index == stack_count then
		geom.h = geom.h + remainder
	end

	return geom
end

local LAYOUT = layout_master_stack

local function create_first_windows()
	local first_window = olvstd.object.Window:new()
	if first_window ~= nil then
		first_window:set_buffer_object(olvstd.object.Buffer:wrap(OLV_DEFAULT_WINDOW_BUFFER))
	else
		show_console_window()
		olv_log_error("FAILED TO CREATE NEW WINDOW")
	end

	MODELINE_WINDOW = olvstd.object.Window:new()
	MODELINE_BUFFER = olvstd.object.Buffer:new()
	MODELINE_WINDOW:set_buffer_object(MODELINE_BUFFER)
	MODELINE_WINDOW:set_attributes(
		OLV_WINATTR_NO_BORDER | OLV_WINATTR_NO_VOID_LINE_MARKERS | OLV_WINATTR_NO_AUTO_SCROLL | OLV_WINATTR_UNLISTED
	)
	MODELINE_BUFFER:set_attributes(OLV_BUFFATTR_UNLISTED)
	olvstd.wm.set_floating(MODELINE_WINDOW.id, true)
end

create_first_windows()

-- Get mode name.
local function mode_name(x)
	if x == OLV_MODE_NORMAL then
		return "NORMAL"
	elseif x == OLV_MODE_INSERT then
		return "INSERT"
	end

	return "UNKNOWN"
end

local function update_modeline()
	local mode = olv_mode_get()
	local mode_display = mode_name(mode)

	local active_buffer = get_active_buffer()
	local active_window = get_active_window()

	local buffer_name = active_buffer:display_name()
	local cursor_count = active_window:cursor_count()

	modeline_set("[" .. mode_display .. "] " .. "[" .. buffer_name .. "]" .. " " .. cursor_count .. " cursor(s)")
end

message_console("Startup: ~" .. STARTUP_MS / 1000 .. " Seconds")
while true do
	local screen_width, screen_height = olv_ui_backend_size()

	-- Poll for stuff.
	olvstd.keyboard.poll_keybinds()
	olvstd.wm.poll_events()

	update_modeline()

	update_list_prompt()

	local modeline_height = 2

	-- Apply layout to non-floating windows.
	olvstd.wm.apply_layout(LAYOUT, { x = screen_width, y = screen_height - modeline_height })

	-- Set modeline window position and size.
	MODELINE_WINDOW:set_position({ x = 0, y = screen_height - modeline_height })
	MODELINE_WINDOW:set_size({ x = screen_width, y = modeline_height })

	-- Set list prompt window position and size.
	if LIST_PROMPT_WINDOW ~= nil then
		local area_size = {
			x = screen_width,
			y = screen_height - modeline_height,
		}

		local size = {
			x = math.floor(area_size.x / 2),
			y = math.floor(area_size.y / 1.5),
		}

		local prev_size = LIST_PROMPT_WINDOW:get_size()
		if prev_size.x ~= size.x and prev_size.y ~= size.y then
			LIST_PROMPT_DIRTY = true
		end

		LIST_PROMPT_WINDOW:set_position({
			x = math.floor((area_size.x - size.x) / 2),
			y = math.floor((area_size.y - size.y) / 2),
		})
		LIST_PROMPT_WINDOW:set_size(size)
	end

	-- Refresh modeline buffer contents.
	if MODELINE_DIRTY and olv_window_get_active() ~= MODELINE_WINDOW.id then
		MODELINE_BUFFER:clear()
		MODELINE_WINDOW:set_buffer_object(MODELINE_BUFFER) -- HACK: Make sure a cursor exists.
		MODELINE_WINDOW:type_text(" ")
		MODELINE_WINDOW:type_text(MODELINE_TEXT)
		MODELINE_WINDOW:type_text(" ")
		MODELINE_WINDOW:type_text("\n")
		MODELINE_WINDOW:type_text(MODELINE_MESSAGE)
		MODELINE_BUFFER:clear_highlights()
		local additional_padding = 2 -- " " 2x
		MODELINE_BUFFER:add_highlight({
			span_start = { x = 0, y = 0 },
			span_end = { x = string.len(MODELINE_TEXT) - 1 + additional_padding, y = 0 },
			fg = 0,
			bg = 12,
		})
		MODELINE_DIRTY = false
	end

	-- Show/hide console window.
	if CONSOLE_WINDOW ~= nil then
		if olv_keymap_focused() == OLV_DEFAULT_KEYMAP then
			CONSOLE_WINDOW:focus()
		end

		if olvstd.wm.is_floating(CONSOLE_WINDOW.id) then
			local padding = { x = 4, y = 2 }

			CONSOLE_WINDOW:set_position({
				x = padding.x,
				y = padding.y,
			})
			CONSOLE_WINDOW:set_size({
				x = screen_width - (padding.x * 2),
				y = screen_height - (padding.y * 2) - modeline_height,
			})
		end
	end
end
