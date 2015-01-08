import my_widget

from libqtile.config import Key, Group, Drag, Click, Screen
from libqtile.command import lazy
from libqtile import hook, layout, bar, widget

#Fix for Java programs
wmname = 'CWM'

#Mod key for key commands
mod = 'mod1'

#Keys
keys = [
	#Toggle layouts
	Key([mod], 'Tab', lazy.nextlayout()),

	#Switch window on stack
	Key([mod], 'k', lazy.layout.down()),
	Key([mod], 'j', lazy.layout.up()),

	#Shuffle window in stack
	Key([mod, 'control'], 'k', lazy.layout.shuffle_down()),
	Key([mod, 'control'], 'j', lazy.layout.shuffle_up()),

	#Toggle window floating
	Key([mod, 'control'], 'space', lazy.window.toggle_floating()),

	#Other layout bindings
	Key([mod], 'n', lazy.layout.normalize()),
	Key([mod, 'control'], 'i', lazy.layout.grow()),
	Key([mod, 'control'], 'm', lazy.layout.shrink()),
	Key([mod, 'control'], 'o', lazy.layout.maximize()),
	Key([mod, 'control'], 'p', lazy.layout.flip()),

	#Screen bindings
	Key([mod], 'Left', lazy.screen.prevgroup()),
	Key([mod], 'Right', lazy.screen.nextgroup()),

	#Shuffle window focus
	Key([mod], 'space', lazy.layout.next()),

	#Send window close signal
	Key([mod], 'w', lazy.window.kill()),

	#Special keyboard keys
	Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer -q -D pulse sset Master 4%+')),
	Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer -q -D pulse sset Master 4%-')),
	Key([], 'XF86AudioMute', lazy.spawn('amixer -q -D pulse sset Master toggle')),
	Key([], 'XF86MonBrightnessUp', lazy.spawn('xbacklight +10')),
	Key([], 'XF86MonBrightnessDown', lazy.spawn('xbacklight -10')),

	#Command
	Key([mod], 'r', lazy.spawncmd()),

	#Common shortcuts
	Key([mod, 'shift'], 'Return', lazy.spawn('urxvt')),
	Key([mod, 'shift'], 'j', lazy.spawn('google-chrome-stable --profile-directory="Default"')),
	Key([mod, 'shift'], 'k', lazy.spawn('google-chrome-stable --profile-directory="Profile 1"')),
	Key([mod, 'shift'], 'h', lazy.spawn('thunar')),
	Key([mod, 'shift'], 'l', lazy.spawn('slimlock')),

	#Qtile bindings
	Key([mod, 'shift'], 'r', lazy.restart()),
	Key([mod, 'shift'], 'q', lazy.shutdown()),
]

#Groups
groups = [
	Group('term'),
	Group('web'),
	Group('chat'),
	Group('files'),
	Group('work'),
	Group('games'),
]

#Group key bindings
for index, group in enumerate(groups, start=1):
	keys.extend([
		Key([mod], str(index), lazy.group[group.name].toscreen()),
		Key([mod, 'control'], str(index), lazy.window.togroup(group.name)),
	])

dgroups_key_binder = None
dgroups_app_rules = []

#Floating windows
floating = [
	('sun-awt-X11-XFramePeer', 'org-spoutcraft-launcher-entrypoint-Start'),
	('Steam', 'Steam'),
	('display', 'Display'),
	('m64py', 'M64py'),
]

#Set necessary windows as floating
@hook.subscribe.client_new
def set_floating(client):
	try:
		if client.window.get_wm_class() and client.window.get_wm_class() in floating or client.window.get_wm_type() == 'dialog' or client.window.get_wm_transient_for():
			client.floating = True
	except:
		pass

#Mouse
mouse = [
	Drag([mod], 'Button1', lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag([mod], 'Button3', lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click([mod], 'Button2', lazy.window.bring_to_front()),
]

#Layouts
layouts = [
	layout.MonadTall(border_focus="#0000ff", border_width=1),
	layout.Max(),
	layout.Floating(),
]

floating_layout = layout.Floating()

#Screens
screens = [
	Screen(
		top=bar.Bar(
			widgets=[
				widget.GroupBox(disable_drag=True, invert_mouse_wheel=True),
				widget.Prompt(),
				widget.WindowName(),
				widget.TextBox("CPU:"),
				widget.CPUGraph(),
				widget.Sep(),
				widget.TextBox("TEMP:"),
				widget.ThermalSensor(tag_sensor='id 0'),
				widget.Sep(),
				widget.TextBox("MEM:"),
				widget.MemoryGraph(),
				widget.Sep(),
				widget.TextBox("VOL:"),
				widget.Volume(pulseaudio=True),
				widget.Sep(),
				widget.TextBox("WLAN:"),
				my_widget.Wlan(interface='wlp8s0'),
				widget.Sep(),
				widget.TextBox("BATT:"),
				widget.Battery(battery_name='BAT1'),
				widget.Sep(),
				widget.Systray(),
				widget.Clock(),
			],
			size=28,
		),
	),
]

#Defaults
widget_defaults = {
	#General
	'font': 'Terminus',
	'fontsize': 14,
	'padding': 4,
	#Highlight
	'highlight_method': 'block',
	'rounded': False,
	#Colors
	'background': '222222',
	'active': 'ffffff',
	'inactive': 'aaaaaa',
	#'this_current_screen_border': 'aa2222',
	'this_current_screen_border': '316a8d',
	#'other_screen_border': '222222',
	'other_screen_border': '444444',
	'urgent_alert_method': 'border',
	'urgent_border': 'ed4035',
	#Graphs
	#'graph_color': 'dd8844',
	'graph_color': 'ed9743',
	#'fill_color': 'dd8844',
	'fill_color': 'ed9743',
	'border_color': '444444',
	#Battery
	'low_foreground': 'ed4035',
	#Thermal Sensor
	'foreground_alert': 'ed4035',
}

auto_fullscreen = True

def main(qtile):
	#Run a setup script that should start before qtile configures anything
	import os
	os.system('~/.config/qtile/setup.sh')
