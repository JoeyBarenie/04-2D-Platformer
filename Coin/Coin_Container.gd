extends Node2D

onready var Coin = load("res://Coin/Coin.tscn")

func spawn(attr, p):
	var coin = Coin.instance()
	for a in attr:
		coin[a] = attr [a]
	coin.position = p
	
func _ready():
	pass
