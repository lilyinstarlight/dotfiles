from libqtile.config import Key, Screen, Group
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

mod = "mod1"

keys = [
	# Switch between windows in current stack pane
	Key([mod], "k", lazy.layout.down()),
	Key([mod], "j", lazy.layout.up()),

	# Move windows up or down in current stack
	Key([mod, "control"], "k", lazy.layout.shuffle_down()),
	Key([mod, "control"], "j", lazy.layout.shuffle_up()),

	# Switch window focus to other pane(s) of stack
	Key([mod], "space", lazy.layout.next()),

	#Key([mod, "shift"], "i", lazy.layout.grow()),
	#Key([mod, "shift"], "m", lazy.layout.shrink()),
	#Key([mod, "shift"], "n", lazy.layout.normalize()),
	#Key([mod, "shift"], "o", lazy.layout.maximize()),
	#Key([mod, "shift"], "space", lazy.layout.flip()),

	Key([mod, "shift"], "Return", lazy.spawn("urxvt")),
	Key([mod, "shift"], "j", lazy.spawn("chromium-browser")),
	Key([mod, "shift"], "h", lazy.spawn("thunar")),
	Key([mod, "shift"], "l", lazy.spawn("slock")),

	# Toggle between different layouts as defined below
	Key([mod], "Tab", lazy.nextlayout()),
	Key([mod], "w", lazy.window.kill()),

	Key([mod, "control"], "r", lazy.restart()),
	Key([mod, "control"], "q", lazy.shutdown()),
	Key([mod], "r", lazy.spawncmd()),
]

groups = [
	Group("term"),
	Group("web"),
	Group("chat"),
	Group("files"),
	Group("work"),
	Group("games"),
]

for index, group in enumerate(groups):
	keys.extend([
		Key([mod], str(index + 1), lazy.group[group.name].toscreen()),
		Key([mod, "shift"], str(index + 1), lazy.window.togroup(group.name)),
	])

dgroups_key_binder = None
dgroups_app_rules = []

@hook.subscribe.client_new
def dialogs(window):
	if(window.window.get_wm_type() == 'dialog' or window.window.get_wm_transient_for()):
		window.floating = True

layouts = [
	layout.Tile(),
]

screens = [
	Screen(
		top=bar.Bar(
			[
				widget.GroupBox(),
				widget.Prompt(),
				widget.WindowName(),
				widget.CPUGraph(),
				widget.MemoryGraph(),
				widget.Battery(battery_name="BAT1"),
				widget.Systray(),
				widget.Clock(),
			],
			30,
		),
	),
]

main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
mouse = ()
auto_fullscreen = True
widget_defaults = {}

import os
os.system('~/.config/qtile/setup.sh')
