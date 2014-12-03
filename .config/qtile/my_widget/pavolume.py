import subprocess

from libqtile import bar
from libqtile.widget import base, volume

__all__ = [
	'PAVolume',
]

class PAVolume(volume.Volume):
	''' Pulse audio version of Volume widget '''
	defaults = [
		("channel", "Master", "Channel"),
		("padding", 3, "Padding left and right. Calculated if None."),
		("theme_path", None, "Path of the icons"),
		("update_interval", 0.2, "Update time in seconds."),
		("emoji", False, "Use emoji to display volume states, only if ``theme_path`` is not set."
			"The specified font needs to contain the correct unicode characters."),
		("mute_command", None, "Mute command"),
		("volume_up_command", None, "Volume up command"),
		("volume_down_command", None, "Volume down command"),
	]

	def __init__(self, **config):
		base._TextBox.__init__(self, '0', width=bar.CALCULATED, **config)
		self.add_defaults(PAVolume.defaults)
		if self.theme_path:
			self.width_type = bar.STATIC
			self.width = 0
		self.surfaces = {}
		self.volume = None
		self.timeout_add(self.update_interval, self.update)

	def button_press(self, x, y, button):
		if button == 5:
			if self.volume_down_command is not None:
				subprocess.call(self.volume_down_command)
			else:
				subprocess.call([
					'amixer',
					'-q',
					'-D',
					'pulse',
					'sset',
					self.channel,
					'4%-'
				])
		elif button == 4:
			if self.volume_up_command is not None:
				subprocess.call(self.volume_up_command)
			else:
				subprocess.call([
					'amixer',
					'-q',
					'-D',
					'pulse',
					'sset',
					self.channel,
					'4%+'
				])
		elif button == 1:
			if self.mute_command is not None:
				subprocess.call(self.mute_command)
			else:
				subprocess.call([
					'amixer',
					'-q',
					'-D',
					'pulse',
					'sset',
					self.channel,
					'toggle'
				])
				self.draw()

	def get_volume(self):
		mixerprocess = subprocess.Popen(
			[
				'amixer',
				'-D',
				'pulse',
				'sget',
				self.channel
			],
			stdout=subprocess.PIPE
		)
		mixer_out = mixerprocess.communicate()[0].decode()
		if mixerprocess.returncode:
			return -1

		if '[off]' in mixer_out:
			return -1

		volgroups = volume.re_vol.search(mixer_out)
		if volgroups:
			return int(volgroups.groups()[0])
		else:
			# this shouldn't happend
			return -1
