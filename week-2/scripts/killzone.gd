extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body: Node2D):
	if _body.name == "player" or _body.name == "Player":
		print("You died.")
		
		if _body.has_node("sfxHurt"):
			_body.get_node("sfxHurt").play()
		
		Engine.time_scale = 0.5
		_body.get_node("CollisionShape2D").set_deferred("disabled", true)
		GameManager.decreaseHealth()
		timer.start()

func _on_timer_timeout():
	# 1. ALWAYS reset time_scale first
	Engine.time_scale = 1.0
	
	# 2. Check the math we just did in GameManager
	if GameManager.lives > 0:
		get_tree().reload_current_scene()
	else:
		# Game Over: go to menu
		get_tree().change_scene_to_file("res://scene/mainmenu.tscn")
