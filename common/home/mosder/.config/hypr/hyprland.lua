-------------------
---- VARIABLES ----
-------------------

-- Files, locations and used programs live in conf/vars.lua so that every
-- required file can get to them as well.
local vars = require("conf.vars")

-----------------------
---- ENV VARIABLES ----
-----------------------

require("conf.env")

-- Gtk - nwglook
hl.env("GTK_THEME", "catppuccin-mocha-mauve-standard+default")

-- Qt - adwaita dark
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- Cursor
hl.env("XCURSOR_THEME", "rose-pine-cursor")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")

-- Misc
hl.env("EDITOR", vars.editor)
hl.env("MAX_ZOOM", "3")

------------------
---- MONITORS ----
------------------

require("conf.monitors")

-------------------
---- AUTOSTART ----
-------------------

require("conf.autostart")

hl.on("hyprland.start", function()
	-- Utils
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd(vars.status_bar)
	hl.exec_cmd(vars.wallpaper_manager)
	hl.exec_cmd(vars.idle_manager)
	hl.exec_cmd(vars.automount)
	hl.exec_cmd(vars.osd .. "-server")

	-- Programs
	hl.dispatch(hl.dsp.exec_cmd(vars.browser, { workspace = "1 silent" }))
	hl.dispatch(hl.dsp.exec_cmd(vars.discord, { workspace = "2 silent" }))
	hl.dispatch(hl.dsp.exec_cmd(vars.terminal, { workspace = "3 silent" }))

	-- Use lockscreen as login
	hl.exec_cmd(vars.lockscreen)
end)

--------------------
---- CATEGORIES ----
--------------------

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 1,

		col = {
			active_border = { colors = { "rgb(df00ff)", "rgb(ff10f0)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		no_focus_fallback = true,
	},

	animations = {
		enabled = true,
	},

	input = {
		kb_layout = "pl",

		kb_options = "caps:escape",

		numlock_by_default = true,

		repeat_rate = 40,
		repeat_delay = 400,

		follow_mouse = 2,
	},

	misc = {
		disable_hyprland_logo = true,

		focus_on_activate = false,

		middle_click_paste = false,
	},

	cursor = {
		zoom_rigid = true,
	},

	ecosystem = {
		no_donation_nag = true,
	},

	dwindle = {
		force_split = 2,
		preserve_split = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 7.5, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 4.04, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.59, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.07, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.11, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.29, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.09, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.27, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 2.85, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.12, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.34, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.04, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.45, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 0.9, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.45, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5.25, bezier = "quick" })

require("conf.categories")

---------------
---- BINDS ----
---------------

-- General
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + N", hl.dsp.exec_cmd("dunstctl close-all"))
hl.bind("SUPER + slash", hl.dsp.exec_cmd(vars.lockscreen))
hl.bind("ALT + space", hl.dsp.exec_cmd("pkill " .. vars.menu .. " || " .. vars.menu))

-- Launch programs
hl.bind("SUPER + T", hl.dsp.exec_cmd(vars.terminal))
hl.bind("SUPER + F", hl.dsp.exec_cmd(vars.file_manager))
hl.bind("SUPER + C", hl.dsp.exec_cmd(vars.terminal .. " start -- " .. vars.editor))
hl.bind("SUPER + B", hl.dsp.exec_cmd(vars.browser))
hl.bind("SUPER + D", hl.dsp.exec_cmd(vars.discord))
hl.bind("SUPER + S", hl.dsp.exec_cmd(vars.steam))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(vars.color_picker .. " -a"))
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd(vars.scripts_dir .. "/zoom.sh"))

-- Take screenshots
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(vars.screenshot .. " -m region --clipboard-only"))

-- Passthru keybinds to VMs
hl.bind("SUPER + P", function()
	hl.dispatch(hl.dsp.exec_cmd('notify-send "Entered passthru submap"'))
	hl.dispatch(hl.dsp.submap("passthru"))
end)
hl.define_submap("passthru", function()
	hl.bind("SUPER + P", hl.dsp.submap("reset"))
end)

-- Move focus
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))

-- Swap windows
hl.bind("SUPER + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))

-- Resize windows manually
hl.bind("SUPER + R", function()
	hl.dispatch(hl.dsp.exec_cmd('notify-send "Entered resize submap"'))
	hl.dispatch(hl.dsp.submap("resize"))
end)
hl.define_submap("resize", function()
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("Escape", hl.dsp.submap("reset"))
	hl.bind("Return", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
	hl.bind("SUPER + R", hl.dsp.submap("reset"))
end)

-- Switch workspaces
-- Move active window to a workspace
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move current workspace to another monitor
hl.bind("SUPER + M", hl.dsp.workspace.move({ monitor = "+1" }))

-- Volume controls
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(vars.osd .. "-client --output-volume raise --max-volume 95"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(vars.osd .. "-client --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(vars.osd .. "-client --output-volume mute-toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(vars.osd .. "-client --input-volume mute-toggle"),
	{ locked = true, repeating = true }
)

-- Player controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(vars.osd .. "-client --playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(vars.osd .. "-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(vars.osd .. "-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(vars.osd .. "-client --playerctl previous"), { locked = true })

require("conf.binds")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

require("conf.rules")

-- Force discord to stay at 2nd workspace
hl.window_rule({ match = { class = "^(discord)$" }, workspace = "2 silent" })

-- Force steam to stay at 5th workspace
hl.window_rule({ match = { class = "^(steam)$" }, workspace = "5 silent" })

-- Ignore maximize requests from apps
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
