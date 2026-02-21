extends Label3D

@export var wave_speed: float = 3.0
@export var wave_height: float = 0.2

var time: float = 0.0
var base_y: float

func _ready() -> void:
	base_y = position.y
	animate_loop()

func _process(delta: float) -> void:
	time += delta
	# Sine wave vertical movement
	position.y = base_y + sin(time * wave_speed) * wave_height

func animate_loop():
	# 1. Reset everything
	self.set("visible_characters", 0)
	self.modulate.a = 1.0
	
	var tween = create_tween()
	
	# 2. Type out text (using the string name of the property to avoid scope errors)
	var total_chars = text.length()
	tween.tween_property(self, "visible_characters", total_chars, 2.0)
	
	# 3. Pause
	tween.tween_interval(1.5)
	
	# 4. Fade away
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	
	# 5. Loop it
	tween.finished.connect(animate_loop, CONNECT_ONE_SHOT)
