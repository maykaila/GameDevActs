extends Area3D

func _ready():
	print("GOAL IS ACTIVE: I am waiting for the player...")

func _on_body_entered(body: Node3D) -> void:
	print("PHYSICS DETECTED: Something touched me! It is named: ", body.name)
	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
