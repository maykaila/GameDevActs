extends Node

@onready var coins_label: Label = %CoinsLabel
var points = 0

func addPoint():
	points += 1
	print(points)
	coins_label.text = "Coins: " + str(points)
