extends Area2D

@export var target_level: PackedScene
@onready var color_rect = $CanvasLayer/ColorRect

func _on_body_entered(body: Node2D) -> void:
	# Optional: ensure only player triggers it
	$CollisionShape2D.set_deferred("disabled", true)

		# Create fade tween
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(color_rect, "color:a", 1.0, 1.0)

		# Wait for fade to finish
	await tween.finished

		# Change scene
	if target_level:
		get_tree().change_scene_to_packed(target_level)
