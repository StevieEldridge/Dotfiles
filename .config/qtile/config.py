# Copyright (c) 2012-2014 Tycho Andersen # Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os, re, socket, subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from CustomVerticalTile import VerticalTile

mod         = "mod1"
terminal    = "kitty"
browser     = "com.brave.Browser"
sessionlock = "betterlockscreen -l"
emacs       = "emacsclient -c -a 'emacs'"
#emacs       = "emacs"
screenshot  = "flameshot gui"

# -------------------------------------------------
# Qtile Color Theme
# -------------------------------------------------

color = dict (
        # Gogh
        #background = ["#292d3e", "#292d3e"],
		#foreground = ["#bfc7df", "#bfc7df"],
		#black      = ["#292d3e", "#292d3e"],
		#red        = ["#f07178", "#f07178"],
		#green      = ["#62de84", "#62de84"],
		#yellow     = ["#ffcb6b", "#ffcb6b"],
		#blue       = ["#75a1ff", "#75a1ff"],
		#magenta    = ["#f580ff", "#f580ff"],
		#cyan       = ["#60baec", "#60baec"],
		#white      = ["#abb2bf", "#abb2bf"],
		#bdrFocus   = "f580ff",
		#bdrNormal  = "5c607f"

        # Catppuccin Frappe
        background = ["#303446", "#303446"],
		foreground = ["#c6d0f5", "#c6d0f5"],
		black      = ["#292c3c", "#292c3c"],
		red        = ["#e78284", "#e78284"],
		green      = ["#a6d189", "#a6d189"],
		yellow     = ["#e5c890", "#e5c890"],
		blue       = ["#8caaee", "#8caaee"],
		magenta    = ["#f4b8e4", "#f4b8e4"],
		cyan       = ["#81c8be", "#81c8be"],
		white      = ["#b5bfe2", "#b5bfe2"],
		bdrFocus   = "a6d189",
		bdrNormal  = "8caaee"


        # Gruvbox
        # background = ["#282828", "#282828"],
		# foreground = ["#ebdbb2", "#ebdbb2"],
		# black      = ["#282828", "#282828"],
		# red        = ["#cc241d", "#cc241d"],
		# green      = ["#98971a", "#98971a"],
		# yellow     = ["#d79921", "#d79921"],
		# blue       = ["#458588", "#458588"],
		# magenta    = ["#b16286", "#b16286"],
		# cyan       = ["#689d6a", "#689d6a"],
		# white      = ["#a89984", "#a89984"],
		# bdrFocus   = "d79921",
		# bdrNormal  = "928374"
	)


# -------------------------------------------------
# Global Variables
# -------------------------------------------------

# Modifies the bar height
barHeight = 26

# Pixel Scale is a global multiplier. Useful for high resolution displays
def scale(initValue):
	pixelScale = 1.0
	return round(initValue * pixelScale)

# -------------------------------------------------
# Keybindings
# -------------------------------------------------

# A list of available commands that can be bound to keys can be found
# at https://docs.qtile.org/en/latest/manual/config/lazy.html

keys = [
	# Commands to launch essential applications
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(emacs), desc="Launch emacs"),
	Key([mod], "b", lazy.spawn(browser), desc="Launches preferred browser"),
	Key([mod, "shift"], "r", lazy.spawncmd(), desc="Uses the qtile spawn"),
    Key([mod], "r",
		lazy.spawn(
            # Specific settings for DMenu such as colors
			"dmenu_run -h " + str(barHeight) +
			" -fn 'FiraCode Nerd Font-12'" +
			" -nb '" + color["background"][0] + "'" +  # Dmenu bar background color
			" -nf '" + color["white"][0] + "'" +       # Dmenu bar text color
			" -shb '" + color["green"][0] + "'" +    # Matched text background color
			" -shf '" + color["black"][0] + "'" +      # Matched text color
			" -sb '" + color["foreground"][0] + "'" +  # Selected background color
			" -sf '" + color["black"][0] + "'" +       # Selected text color
			" -nhb '" + color["foreground"][0] + "'" + # Partial matched text background color
			" -nhf '" + color["black"][0] + "'"        # Partial matched text color
		),
		desc="Spawn a command using DMenu"
	),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move f to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
	Key([mod], "i", lazy.layout.grow(), desc="Grows window"),
	Key([mod], "o", lazy.layout.shrink(), desc="Shrinks window"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "m", lazy.layout.maximize(), desc="Toggles fullscreen mode"),
	Key([mod], "w", lazy.window.toggle_floating(), desc="Toggles floating mode"),
    Key([mod, "shift"], "m", lazy.window.toggle_fullscreen(), desc="Toggles fullscreen mode"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "control"], "Return", lazy.layout.toggle_split()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Kills a window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    # Manages qtile session
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Exit Qtile"),
    Key([mod, "control"], "l", lazy.spawn(sessionlock)),

	# Manages multiple monitors
	#Key([mod], "e", lazy.to_screen(0), desc="Focuses to monitor 0"),
	#Key([mod], "w", lazy.to_screen(1), desc="Focuses to monitor 1"),
	Key([mod, "shift"], "space", lazy.next_screen(), desc="Move focus to next monitor"),

	# Takes a screenshot and saves it to clipboard
	Key([mod], "Print", lazy.spawn(screenshot)),
]


# -------------------------------------------------
# Custom Workspace Handling For Each Screen
# -------------------------------------------------

# By default Qtile shares its workspaces(aka groups) between all screens.
# I have changed how workspaces and screens are handled where each screen
# now has seperate workspaces

# Configures the workspaces for each screen where each string in the array
# represents a different set of workspaces for each screen
screenGroups = ["asdfg", "12345"]
allGroups = ''.join(screenGroups)
groups = [Group(i) for i in allGroups]

# Separates the groups for each screen while navigating to a group
for j, names in enumerate(screenGroups):
    keys.extend(
		Key([mod], i, lazy.to_screen(j), lazy.group[i].toscreen()) for i in names
	)

# Moves a window to a different workspace
keys.extend(
	Key([mod, "shift"], i, lazy.window.togroup(i)) for i in allGroups
)


# -------------------------------------------------
# Layout Settings
# -------------------------------------------------

# Config parameters that most layouts use
layoutTheme = {
    "border_width":  scale(3),
    "margin":        scale(12),
    "border_focus":  color["bdrFocus"],
    "border_normal": color["bdrNormal"]
}


layouts = [
    layout.MonadTall(**layoutTheme),
    VerticalTile(** {
        "border_width":  layoutTheme["border_width"],
		"margin":        round(layoutTheme["margin"] * 0.667),
		"border_focus":  layoutTheme["border_focus"],
		"border_normal": layoutTheme["border_normal"]
	}),
    layout.Max(**layoutTheme),
	# layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Stack(num_stacks=2),
	# layout.Bsp(**layoutTheme),
	# layout.Matrix(**layoutTheme),
    # layout.MonadWide(**layoutTheme),
    # layout.RatioTile(**layoutTheme),
    # layout.Tile(**layoutTheme),
    # layout.TreeTab(**layoutTheme),
	# layout.Zoomy(),
]


# -------------------------------------------------
# Widget Settings
# -------------------------------------------------

widget_defaults = dict(
	font     = "Ubuntu Bold",
	fontsize = 14,
	padding = scale(6),
	background = color["background"],
	foreground = color["foreground"],
)
extension_defaults = widget_defaults.copy()

barMarginX = 10  # Margin on the left and right side of the bar
sepPadding = 10  # Spacing between each widget

seperator = widget.Sep(
    linewidth = scale(0),
    padding = scale(sepPadding),
)

# Initializes an array of widgets for one screen bar
# @Input - A screen number for a given screen
def initWidgets(screenNum):
	baseWidgets = [
		widget.Sep(
			linewidth = scale(0),
			padding = scale(barMarginX),
		),
		widget.GroupBox(
			visible_groups=[char for char in screenGroups[screenNum]],
			borderwidth = scale(4),
			active = color["green"],
			inactive = color["foreground"],
			highlight_color = color["background"],
			highlight_method = "line",
			this_current_screen_border = color["green"],
			this_screen_border = color["green"],
			other_current_screen_border = color["green"],
			other_screen_border = color["green"],
			rounded = False,
			disable_drag = True,
		),
		widget.Sep(
			linewidth = scale(2),
			padding = scale(sepPadding),
			size_percent = 70,
		),
		widget.CurrentLayout(
			foreground = color["yellow"],
		),
		widget.Sep(
			linewidth = scale(2),
			padding = scale(sepPadding),
			size_percent = 70,
		),
		widget.Prompt(),
		widget.WindowName(
			foreground = color["blue"],
		),
		widget.Chord(
			chords_colors={
				"launch": ("#ff0000", "#ffffff"),
			},
			name_transform=lambda name: name.upper(),
		),
		widget.Systray(
			icon_size = 20,
		),
        seperator,
		widget.CheckUpdates(
			display_format = "upd: {updates}",
			distro = "Arch",
			no_update_string = "0",
			update_interval = 300,
			background = color["green"],
			colour_have_updates = color["black"],
			colour_no_updates = color["black"],
		),
        seperator,
		widget.CPU(
			format = "cpu: {load_percent}%",
			update_interval = 1.0,
			background = color["red"],
			foreground = color["black"],
		),
        seperator,
		widget.Memory(
			measure_mem = "G",
			update_interval = 1.0,
			format = "ram: {MemUsed: .1f} /{MemTotal: .1f}",
			background = color["yellow"],
			foreground = color["black"],
		),
        seperator,
		widget.Clock(
			format = "%m/%d  %I:%M %p",
			background = color["blue"],
			foreground = color["black"],
		),
        seperator,
		widget.Volume(
			limit_max_volume=True,
			update_interval = 0.1,
			fmt = "vol: {}",
			step = 5,
			background = color["magenta"],
			foreground = color["black"],
		),
		widget.Sep(
			linewidth = scale(0),
			padding = scale(barMarginX),
		),
	]

	if not screenNum == 0:
		del baseWidgets[8:9]  # Removes SysTray on secondary monitors

	return baseWidgets


# -------------------------------------------------
# Screen Initialization
# -------------------------------------------------

screens = [
    Screen(
		top=bar.Bar(
			widgets = initWidgets(0),
            size = scale(barHeight),
			opacity = 1.0,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
    Screen(
        top=bar.Bar(
			widgets = initWidgets(1),
            size = scale(barHeight),
			opacity = 1.0,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# -------------------------------------------------
# Mouse Bindings
# -------------------------------------------------

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


# -------------------------------------------------
# Floating Window Settings
# -------------------------------------------------

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)


# -------------------------------------------------
# Global Settings
# -------------------------------------------------

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
cursor_warp = False

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None


# -------------------------------------------------
# Hooks
# -------------------------------------------------

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~")
    subprocess.Popen([home + "/.config/qtile/autostart.sh"])


# -------------------------------------------------
# Other
# -------------------------------------------------

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

