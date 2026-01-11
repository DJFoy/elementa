extends Control
signal world_change_request


func _on_new_game_pressed() -> void:
	print("Pressed New Game")
	world_change_request.emit("res://scenes/player_init.tscn")


func _on_load_game_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit() # Replace with function body.


func _on_debug_pressed() -> void:
	world_change_request.emit("res://scenes/debug.tscn")
