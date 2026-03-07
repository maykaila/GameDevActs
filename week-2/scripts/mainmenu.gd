extends Control

func _on_start_pressed() -> void:
	# This will only run ONCE when you actually click the button
	get_tree().change_scene_to_file("res://scene/level1.tscn")

func _on_quit_pressed():
	get_tree().quit()
