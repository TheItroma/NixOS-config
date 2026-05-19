require("animations")
require("monitor")
require("binds")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 1,
		border_size = 4,

		col = {
			active_border = "rgba(000000)",
			inactive_border = "rgba(595959aa)",
		},
		layout = "master",
		allow_tearing = false,
		resize_on_border = false,
		snap = {
			enabled = true,
		},
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

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
			enabled = true,
		},
	},

	animations = {
		enabled = true,
	},
	misc = {
		disable_hyprland_logo = true,
	},
})
