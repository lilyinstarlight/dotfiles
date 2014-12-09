from libqtile.widget import base
from pythonwifi.iwlibs import Wireless, Iwstats


class Wlan(base.InLoopPollText):
	"""
		Displays Wifi ssid and quality.
	"""
	defaults = [
		('interface', 'wlan0', 'The interface to monitor'),
		('update_interval', 1, 'The update interval.'),
	]
	def __init__(self, **config):
		base.InLoopPollText.__init__(self, **config)
		self.add_defaults(Wlan.defaults)

	def poll(self):
		try:
			interface = Wireless(self.interface)
			essid = interface.getEssid()
			if not essid:
				return "Off"
			quality = interface.getStatistics()[1].quality
			return "{} {}/70".format(essid, quality)
		except IOError:
			return "Nonexistent"
