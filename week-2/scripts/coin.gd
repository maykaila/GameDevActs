extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body: Node2D):
	if (body.name == "player"):
		queue_free()
		game_manager.addPoint()
	
