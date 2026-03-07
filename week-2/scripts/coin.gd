extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D):
	$CollisionShape2D.set_deferred("disabled", true)
	if (_body.name == "player"):
		animation_player.play("coinpickup")
		GameManager.addPoint()
