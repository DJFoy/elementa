extends Control
signal new_game
signal debug

func _on_new_game_pressed() -> void:
	print("Pressed New Game")
	new_game.emit()


func _on_load_game_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit() # Replace with function body.


func _on_debug_pressed() -> void:
	debug.emit() # Replace with function body.
