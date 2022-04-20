extends Area2D


func _ready():
	pass


func _on_Portal_entered(body):
	if body.name == "Player":
		if name == "Portal_to_2":
			Global.level = 1
		if Global.level < Global.levels.size():
			get_tree().changed_scene(Global.levels[Global.level])
		else:
			get_tree().changed_scene("res://Level/Game_Over.tscn")
