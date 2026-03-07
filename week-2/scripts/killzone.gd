extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body: Node2D):
	if _body.name == "player" or _body.name == "Player":
		print("You died.")
		Engine.time_scale = 0.5
		
		# Prevent the player from falling forever while waiting for the timer
		_body.get_node("CollisionShape2D").set_deferred("disabled", true)
		
		# Update the data in GameManager
		GameManager.decreaseHealth()
		
		# Start the slow-motion delay
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
