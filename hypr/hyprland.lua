-- https://www.github.com/nyxellang/my_hypr_config
-- hyprland.lua
-- this config is for hyprland 0.55+

--------------------
-- VARIABLES
--------------------
local terminal = "kitty"
local fileManager = "kitty yazi"
local menu = "wofi --show drun"
local browser = "firefox"
local mainMod = "SUPER"

--------------------
-- MONITOR
--------------------
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })

--------------------
-- ENVIRONMENT VARIABLES
--------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--------------------
-- AUTOSTART
--------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("udiskie --automount --notify")
	hl.exec_cmd("swaync")
	hl.exec_cmd(
		"swayidle -w timeout 1800 'hyprlock' timeout 3600 'systemctl suspend' resume 'hyprctl dispatch dpms on'"
	)
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaybg -i ~/my_hypr_config/back2.png -m fill")
	hl.exec_cmd("gammastep -O 2400")
	hl.exec_cmd("wl-paste --watch cliphist store")
end)

--------------------
-- MAIN CONFIG
--------------------
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 2,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(89b4faee)", "rgba(a6e3a1ee)", "rgba(89dcebee)" }, angle = 45 },
			inactive_border = "rgba(313244aa)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 12,
		active_opacity = 1.0,
		inactive_opacity = 0.97,
		dim_inactive = true,
		dim_strength = 0.08,
		shadow = {
			enabled = true,
			range = 30,
			render_power = 3,
			color = "rgba(00000099)",
			offset = { 0, 4 },
			scale = 1.0,
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			new_optimizations = true,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
		smart_split = false,
		smart_resizing = true,
		special_scale_factor = 0.97,
	},

	master = {
		new_status = "master",
		new_on_top = false,
		mfact = 0.55,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,
		enable_swallow = true,
		swallow_regex = "^(kitty)$",
	},

	input = {
		kb_layout = "us,ara",
		kb_variant = "intl",
		kb_options = "grp:alt_shift_toggle",
		follow_mouse = 1,
		mouse_refocus = true,
		sensitivity = 0.0,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = false,
			tap_to_click = true,
			tap_and_drag = true,
			drag_lock = 0,
			clickfinger_behavior = false,
			middle_button_emulation = true,
			scroll_factor = 1.0,
		},
	},
})

--------------------
-- BEZIER CURVES
--------------------
hl.curve("wind", { type = "bezier", points = { { 0.05, 1 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.2 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.4 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1.1, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0 }, { 0.35, 1 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1.1 }, { 0.68, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("easeInOutBack", { type = "bezier", points = { { 0.68, -0.6 }, { 0.32, 1.6 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("bounce", { type = "bezier", points = { { 1, 1.6 }, { 0.1, 0.85 } } })

--------------------
-- ANIMATIONS
--------------------
-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "wind", style = "slide" })
-- Border
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 80, bezier = "linear", style = "loop" })
-- Fade
hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "smoothOut" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "easeOutExpo" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, bezier = "easeOutExpo" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 5, bezier = "smoothIn" })
-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOutCubic", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "easeInOutBack", style = "slidevert" })
-- Layers
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "easeOutExpo", style = "popin 80%" })

--------------------
-- GESTURES
--------------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "up", action = "close" })

--------------------
-- KEYBINDINGS
--------------------

-- App launchers
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("network_manager"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + DELETE", hl.dsp.exec_cmd("loginctl terminate-user $USER"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("lutris"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("Telegram"))
hl.bind("Print", hl.dsp.exec_cmd("quickshell -c hyprquickshot -n"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("vscodium"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("kitty nvim"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("discord"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("pkill waybar"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("waybar"))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("wlogout"))

-- Window management
hl.bind(mainMod .. " + A", hl.dsp.window.pin())
hl.bind(mainMod .. " + SPACE", hl.dsp.window.center())

-- Resize (repeating)
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

-- Focus (arrow keys)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Focus (vim keys)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- Workspaces 1–9
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
-- Workspace 10 (key 0)
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Silent move to workspaces 1–5 (stay on current workspace)
for i = 1, 5 do
	hl.bind(mainMod .. " + CTRL + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Cycle workspaces with Tab
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse drag/resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys (repeating + locked)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && ~/.config/dunst/scripts.sh volume"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/.config/dunst/scripts.sh volume"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && ~/.config/dunst/scripts.sh brightness"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && ~/.config/dunst/scripts.sh brightness"),
	{ repeating = true, locked = true }
)

-- Media control (locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Notification controls (swaync)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -c")) -- close latest
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -C")) -- close all
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd("swaync-client -t")) -- toggle DND
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("swaync-client -H")) -- show/hide center

--------------------
-- LAYER RULES
--------------------
-- Blur (replaces blurls / blurs directives)
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "wofi" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync" }, blur = true })
hl.layer_rule({ match = { namespace = "wlogout" }, blur = true })

-- Animations for layer surfaces
hl.layer_rule({ match = { namespace = "waybar" }, animation = "slide" })

--------------------
-- WINDOW RULES
--------------------
-- Float
hl.window_rule({ match = { class = "pavucontrol" }, float = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { title = "Picture-in-Picture" }, float = true })
hl.window_rule({ match = { class = "gnome-calculator" }, float = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true })

-- Center
hl.window_rule({ match = { class = "pavucontrol" }, center = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, center = true })
hl.window_rule({ match = { class = "blueman-manager" }, center = true })

-- Opacity (active / inactive)
hl.window_rule({ match = { class = "kitty" }, opacity = "0.96 0.92" })
hl.window_rule({ match = { class = "vscodium" }, opacity = "0.96 0.92" })
hl.window_rule({ match = { class = "firefox" }, opacity = "0.98 0.95" })
hl.window_rule({ match = { class = "org.telegram.desktop" }, opacity = "0.98 0.95" })
hl.window_rule({ match = { class = "steam" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "lutris" }, opacity = "1.0 1.0" })

-- Animation overrides
hl.window_rule({ match = { class = "wofi" }, animation = "slide" })
