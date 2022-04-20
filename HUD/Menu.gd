extends Control


func _ready():
	pass


func _on_Save_pressed():
	Global.save_game(0)


func _on_Load_pressed():
	Global.load_game(0)
