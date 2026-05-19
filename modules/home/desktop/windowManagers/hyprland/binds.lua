mod = "SUPER"

appLauncher = "pkill rofi || rofi -show run"

fileManager = "kitty yazi"
terminal = "kitty"
browser = "librewolf"
screenShot = "hyprshot -zm region"
ocr = "~/.config/tools/ocr.sh"

wallpaperSelector = "~/.config/waypaper/rofi.sh"

-- Open apps

hl.bind(mod .. " + R", hl.dsp.exec_cmd(appLauncher))

hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + M", hl.dsp.exec_cmd(wallpaperSelector))

-- Compositor commands

hl.bind(mod .. " + C", hl.dsp.window.close())

-- Move focus

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "l" }))

-- Workspaces 1-10

for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace

hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special())
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))

-- Multimedia

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause --player=spotifyd,spotify"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next --player=spotifyd,spotify"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous --player=spotifyd,spotify"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 2.5%-"))

hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl next --player=spotifyd,spotify"))
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl previous --player=spotifyd,spotify"))

-- Misc

hl.bind("Print", hl.dsp.exec_cmd(screenShot))

-- bind = $MOD SHIFT, C, exec, $ocr
-- bind = $MOD, I, exec, waypaper --random
-- # Move/resize windows with MOD + LMB/RMB and dragging
