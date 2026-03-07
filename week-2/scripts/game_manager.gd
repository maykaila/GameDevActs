extends Node

@onready var coins_label: Label = $UI/Coins/CoinsLabel
@export var hearts : Array[Node]

var points = 0
var lives = 3

func _process(_delta):
	var current_scene = get_tree().current_scene
	if not current_scene:
		return
	
	# We force everything to lowercase to stop case-sensitivity issues for good
	var s_name = current_scene.name.to_lower()

	if "mainmenu" in s_name:
		self.visible = false
		$UI.visible = false # CRITICAL: Hide the child directly to bypass CanvasLayer
	elif "level1" in s_name:
		self.visible = true
		$UI.visible = true
		$UI/Coins.visible = false # Hide only the coins as requested
		$UI/Hearts.visible = true
	elif "level2" in s_name:
		self.visible = true
		$UI.visible = true
		$UI/Coins.visible = true
		$UI/Hearts.visible = true

func _ready():
	update_ui()
	
func update_ui():
	if coins_label:
		coins_label.text = "Coins: " + str(points)

func decreaseHealth():
	lives -= 1
	points = 0
	update_ui()
	
	for h in 3:
		if(h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
			
	if lives > 0:
		get_tree().call_deferred("reload_current_scene") # Prevents physics crash
	else:
		# Reset everything for a fresh start from the menu
		lives = 3
		for h in 3:
			hearts[h].show()
		get_tree().change_scene_to_file("res://scene/mainmenu.tscn")

func addPoint():
	points += 1
	update_ui()
