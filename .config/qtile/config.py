from libqtile.config import Key, Group, Drag, Click, Screen
from libqtile.command import lazy
from libqtile import hook, layout, bar, widget

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

	#Other layout bindings
	Key([mod, 'shift'], 'i', lazy.layout.grow()),
	Key([mod, 'shift'], 'm', lazy.layout.shrink()),
	Key([mod, 'shift'], 'n', lazy.layout.normalize()),
	Key([mod, 'shift'], 'o', lazy.layout.maximize()),
	Key([mod, 'shift'], 'space', lazy.layout.flip()),

	#Shuffle window focus
	Key([mod], 'space', lazy.layout.next()),

	#Send window close signal
	Key([mod], 'w', lazy.window.kill()),

	#Special keyboard keys
	Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer set Master 3%+')),
	Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer set Master 3%-')),
	Key([], 'XF86AudioMute', lazy.spawn('amixer set Master toggle')),

	#Command
	Key([mod], 'r', lazy.spawncmd()),

	#Common shortcuts
	Key([mod, 'shift'], 'Return', lazy.spawn('urxvt')),
	Key([mod, 'shift'], 'j', lazy.spawn('chromium-browser')),
	Key([mod, 'shift'], 'h', lazy.spawn('thunar')),
	Key([mod, 'shift'], 'l', lazy.spawn('slock')),

	#Qtile bindings
	Key([mod, 'control'], 'r', lazy.restart()),
	Key([mod, 'control'], 'q', lazy.shutdown()),
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
		Key([mod, 'shift'], str(index), lazy.window.togroup(group.name)),
	])

#Floating windows
floating = [
	'org-spoutcraft-launcher-entrypoint-Start',
]

#Set necessary windows as floating
@hook.subscribe.client_new
def set_floating(client):
	if client.window.get_wm_class() in floating or client.window.get_wm_type() == 'dialog' or client.window.get_wm_transient_for():
		client.floating = True

#Mouse
mouse = [
	Drag([mod], 'Button1', lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag([mod], 'Button3', lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click([mod], 'Button2', lazy.window.bring_to_front()),
]

#Layouts
layouts = [
	layout.Tile(),
	layout.Max(),
	layout.MonadTall(),
]

#Screens
screens = [
	Screen(
		top=bar.Bar(
			[
				widget.GroupBox(),
				widget.Prompt(),
				widget.WindowName(),
				widget.CPUGraph(),
				widget.MemoryGraph(),
				widget.Battery(battery_name='BAT1'),
				widget.Systray(),
				widget.Clock(),
			],
			30,
		),
	),
]

#Run a setup script that should start before qtile configures anything
import os
os.system('~/.config/qtile/setup.sh')
