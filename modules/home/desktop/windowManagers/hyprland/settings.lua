hl.on("hyprland.start", function()
	hl.exec_cmd("hyprsunset -t 3400k")
	hl.exec_cmd("spotify")
end)

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 2,
		border_size = 5,

		col = {
			active_border = "rgba(00000000)",
			inactive_border = "rgba(595959aa)",
		},

		layout = "dwindle",
		allow_tearing = false,
		resize_on_border = false,
		snap = {
			enabled = true,
		},
	},

	decoration = {
		rounding = 20,
		rounding_power = 2,

		border_part_of_window = false,

		active_opacity = 0.85,
		inactive_opacity = 0.75,

		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			xray = true,
			vibrancy = 0.2,
			vibrancy_darkness = 0.1,
		},

		shadow = {
			enabled = false,
		},

		glow = {
			enabled = false,
		},
	},

	animations = {
		enabled = true,
	},
	misc = {
		disable_hyprland_logo = true,
	},
	binds = {
		scroll_event_delay = 100,
		workspace_back_and_forth = true,
		hide_special_on_workspace_change = true,
	},
})
