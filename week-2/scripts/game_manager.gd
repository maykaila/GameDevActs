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
		$UI.visible = false 
		
		# RESET DATA FOR NEXT GAME
		if lives != 3:
			lives = 3
			points = 0
			for h in hearts:
				if h != null:
					h.show()
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
	# Ensure hearts are visible whenever a new level starts
	for h in hearts:
		if h != null:
			h.show()
	update_ui()
	
func update_ui():
	if coins_label:
		coins_label.text = "Coins: " + str(points)

func decreaseHealth():
	lives -= 1
	points = 0
	update_ui()
	
	# Correct Math: Hide hearts based on remaining lives
	for h in 3:
		if h < lives:
			hearts[h].show()
		else:
			hearts[h].hide()


func addPoint():
	points += 1
	update_ui()
