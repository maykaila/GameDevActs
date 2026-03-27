extends CanvasLayer

func _ready():
	# Only show touch controls if the device actually has touch support
	# Or if we are explicitly on a mobile platform
	if OS.get_name() == "Windows" or OS.get_name() == "macOS" or OS.get_name() == "Linux":
		# Check if touch is NOT emulated (meaning we are definitely on PC)
		if not DisplayServer.is_touchscreen_available():
			hide()
