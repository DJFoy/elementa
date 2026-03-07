extends Control
signal world_change_request

@onready var scene_trans:= get_node("SceneTransition")

func _ready() -> void:
	SceneTransition.fade_in(2)


func _on_new_game_pressed() -> void:
	print("Pressed New Game")
	world_change_request.emit("res://scenes/UI/player_init.tscn")


func _on_load_game_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit() # Replace with function body.


func _on_debug_pressed() -> void:
	world_change_request.emit("res://scenes/UI/debug.tscn")
